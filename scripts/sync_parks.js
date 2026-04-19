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
// Increase timeout for large migrations
db.settings({
    ignoreUndefinedProperties: true,
    preferRest: true, // Sometimes more stable for huge migrations in serverless environments
});

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

  const activeParks = records.filter(r => r.status === 'active');
  const totalToSync = activeParks.length;
  console.log(`Total records from CSV: ${records.length}`);
  console.log(`Active parks: ${totalToSync}`);

  const BATCH_SIZE = 500;
  const CONCURRENCY = 10; // Process 10 batches in parallel
  let currentCount = 0;
  
  const chunks = [];
  for (let i = 0; i < activeParks.length; i += BATCH_SIZE) {
    chunks.push(activeParks.slice(i, i + BATCH_SIZE));
  }

  console.log(`Split into ${chunks.length} batches. Syncing with concurrency ${CONCURRENCY}...`);

  for (let i = 0; i < chunks.length; i += CONCURRENCY) {
    const pool = chunks.slice(i, i + CONCURRENCY).map(async (chunk, index) => {
      const batch = db.batch();
      chunk.forEach(park => {
        const docRef = db.collection('parks').doc(park.reference);
        let lat = parseFloat(park.latitude);
        let lon = parseFloat(park.longitude);
        
        batch.set(docRef, {
          reference: park.reference,
          name: park.name,
          state: park.state,
          latitude: isNaN(lat) ? null : lat,
          longitude: isNaN(lon) ? null : lon,
          lastUpdated: admin.firestore.FieldValue.serverTimestamp()
        }, { merge: true });
      });
      
      await batch.commit();
      currentCount += chunk.length;
      console.log(`Progress: ${currentCount}/${totalToSync} parks synced...`);
    });

    await Promise.all(pool);
  }

  console.log(`Successfully synced all ${currentCount} parks to Firestore.`);
}

sync().catch(err => {
  console.error(err);
  process.exit(1);
});

