const admin = require('firebase-admin');
const axios = require('axios');
const { parse } = require('csv-parse/sync');

const SERVICE_ACCOUNT = process.env.FIREBASE_SERVICE_ACCOUNT;
const CSV_URL = 'https://wwff.co/wwff-data/wwff_directory.csv';

if (!SERVICE_ACCOUNT) {
  console.error("FIREBASE_SERVICE_ACCOUNT is required.");
  process.exit(1);
}

// Strip BOM if present
const cleanServiceAccount = SERVICE_ACCOUNT.trim().replace(/^\uFEFF/, '');

admin.initializeApp({
  credential: admin.credential.cert(JSON.parse(cleanServiceAccount))
});


const db = admin.firestore();

async function sync() {
  console.log("Fetching CSV...");
  const response = await axios.get(CSV_URL);
  const data = response.data;

  // Clean preamble
  const lines = data.split('\n');
  const startIndex = lines.findIndex(l => l.startsWith('reference,status'));
  if (startIndex === -1) throw new Error("CSV header not found");

  const csvContent = lines.slice(startIndex).join('\n');
  const records = parse(csvContent, {
    columns: true,
    skip_empty_lines: true
  });

  console.log(`Total records from CSV: ${records.length}`);

  const activeParks = records.filter(r => r.status === 'active');
  console.log(`Active parks: ${activeParks.length}`);

  const totalToSync = activeParks.length;
  let batch = db.batch();
  let count = 0;
  let batchCount = 0;

  for (const park of activeParks) {
    const docRef = db.collection('parks').doc(park.reference);
    
    let lat = parseFloat(park.latitude);
    let lon = parseFloat(park.longitude);

    // Handheld verification: if coordinates are invalid, we leave as null
    // or we could try to look them up. 
    // Given the scale, individual lookups during sync is risky.
    
    batch.set(docRef, {
      reference: park.reference,
      name: park.name,
      state: park.state,
      latitude: isNaN(lat) ? null : lat,
      longitude: isNaN(lon) ? null : lon,
      lastUpdated: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    count++;
    batchCount++;

    if (batchCount >= 500) {
      await batch.commit();
      console.log(`Committed ${count}/${totalToSync} parks...`);
      batch = db.batch();
      batchCount = 0;
    }
  }

  if (batchCount > 0) {
    await batch.commit();
  }

  console.log(`Successfully synced ${count} parks to Firestore.`);
}

sync().catch(console.error);
