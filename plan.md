# WWFF on the GO - Geliştirme Planı

## Proje Özeti
WWFF (World Wide Flora & Fauna) parklarında veya evinde telsiz görüşmeleri yapan amatör telsizciler için tasarlanmış, tamamen çevrimdışı (offline-first) çalışabilen modern bir mobil loglama uygulaması. Giriş/kayıt (login) gerektirmez ve cihaz hafızasında güvenle log tutar.

## Mimari ve Altyapı Kararları
- **Platform:** Flutter (Android & iOS)
- **Mimari Kod Yapısı:** Feature-First (Özellik Odaklı), Clean Architecture prensipleri (presentation, domain, data).
- **Durum Yönetimi (State Management):** Riverpod.
- **Yönlendirme (Routing):** GoRouter.
- **Yerel Veritabanı:** Isar Database (Yüksek performanslı çevrimdışı depolama, sorgu kolaylığı).
- **Çoklu Dil (Localization):** İngilizce (EN) ve Türkçe (TR) desteği.
- **Tasarım Dili / Theme:** Açık tema, "Glassmorphism" detaylar (Organik Cam Hissiyatı), `Geist` font ailesi (Google Fonts) ve pürüzsüz `animated_notch_bottom_bar`.
- **Canlı Spot Sağlayıcı:** WWFF resmi JSON spot akışı (`wwff.co/static/spots.json`).
- **Görüşme (QSO) Dışa Aktarımı:** WWFF kurallarına tam uyumlu zorunlu alanları (CALL, QSO_DATE, BAND vb.) içeren ".ADIF" formatı.
- **Favori Park / Ayar Yedekleme:** Tercih edilen park ve işaretlerin çevrimdışı (JSON/XML) olarak yedeklenip geri yüklenebilmesi.
- **Park Veritabanı Backend:** Firebase Cloud Firestore platformu (Park listeleri statik okunacak).

---

## Aşama Aşama Uygulama Adımları (Phases)

### Aşama 1: Proje Kurulumu ve İskelet (Scaffolding)
- Yeni Flutter projesinin (WWFFontheGO) `/WWFFontheGO` dizininde ayağa kaldırılması.
- Feature-driven klasör yapısının oluşturulması (`lib/features/logging`, `lib/features/spots`, `lib/features/settings` vb.).
- Öz çekirdek paketin (`hooks_riverpod`, `go_router`, `isar`, `flutter_localizations`, `animated_notch_bottom_bar`) projeye dahil edilmesi.
- UI katmanında seçilen "Glassmorphism & Doğa" açık renk paletinin, global Material 3 temasının ve Geist tipografisinin sisteme entegre edilmesi.

### Aşama 2: Yerel Veritabanı (Isar) Şemalarının Kurulması
- **QSO (Log) Şeması:** WWFF ADIF kurallarını kapsayacak şekilde; `callsign`, `qsoDate`, `timeOn`, `band`, `mode`, `stationCallsign`, `operator`, `mySig`, `mySigInfo`, `sig`, `sigInfo` (P2P), `comment` gibi alanların tanımlanıp Isar kodlarının üretilmesi (`build_runner`).
- **Favoriler Şeması:** Favori çağrı işaretleri veya park referans kodlarını saklayacak yapılar.
- **Kullanıcı/Ayar Şeması:** Uygulamaya ilk girişte girilen kendi çağrı işaretiniz vb. varsayılan değerler için.
- Veri erişim mimarisinin (Local Data Source & Repository Interface) Riverpod `Provider`'ları olarak ayrılması.

### Aşama 3: Ana UI, Yönlendirme ve Dil Altyapısı
- `.arb` formatında (intl) çoklu dil sözlüklerinin İngilizce ve Türkçe için yapılandırılması.
- Uygulamanın ana `Scaffold` yapısının kurulup altına istenen animasyonlu çentikli alt barın (`animated_notch_bottom_bar`) yerleştirilmesi.
- GoRouter üzerinden "Geçmiş Loglar", "Yeni Log Gir", "Canlı Spotlar", ve "Ayarlar" sekmelerinin bağlanıp sayfa boşluklarının (Placeholder) doldurulması.

### Aşama 4: QSO Loglama Modülü (Logging Feature)
- Hızlı veri girişi için akıcı ve hatasız giriş ekranlarının (QSO Form) tasarlanması. (RST Sent/Rcvd otomatik doldurulması, Band ve Modların liste içinden rahatça seçilebilmesi).
- Kaydedilen tüm telsiz görüşmelerinin okunabilir, modern bir liste (ListTile/Card) görünümü ile sergilenmesi.
- Eklenen kayıtları sağa/sola kaydırarak silme veya üzerine tıklayarak düzenleme fonksiyonları.

### Aşama 5: Canlı Spotlar Modülü (Spots Feature)
- `dio` veya `http` paketi kullanılarak `wwff.co/static/spots.json` ağından aktif spotların çekilmesi.
- Uygulamanın tasarımıyla uyumlu bir şekilde listede spot satırlarının gösterilmesi.
- Satırlara veya özel bir butona tıklandığında, çekilen spotun bilgilerinin (Frekans, Karşılaştırma Çağrı İşareti, Park bilgisi vb.) doğrudan "Yeni Log Gir" sekmesine ön doldurulmuş (Pre-filled) şekilde aktarılması.

### Aşama 6: Referans Park Listeleri Modülü
- Uygulamaya Firebase bağlantısının (`firebase_core`) kurulması ve güvenli okuma izinlerinin ayarlanması.
- Sunucudan Park verilerinin liste halinde çekilerek, Firebase Storage'dan gelebilecek arkaplan resimleri veya referans görsellerinin cam/bulanıklık (glassmorphism) teması ile süslenerek kart şeklinde gösterilmesi.

### Aşama 7: Dışa ve İçe Aktarım Mekanizmaları (Import/Export)
- **ADIF Log Yaratıcısı:** Isar DB'de duran tüm (veya seçilen) logların iteratif şekilde WWFF tarafından hatasız onaylanacak standart bir `.adif` karakter dizisine (string) dönüştürülmesi.
- `path_provider` ve `share_plus` kullanarak üretilen ADIF dosyasının telefona kaydedilmesi ya da Email / WhatsApp üzerinden paylaşılabilmesi.
- Favoriler/Ayar verilerinin JSON serileştirilmesi ile `.json` yedek dosyası export ve import özelliklerinin yazılması.

### Aşama 8: Testler, İyileştirmeler ve Paketleme
- Ekran geçişleri, veritabanı performans testlerinin yapılması.
- Seçtiğimiz uygulama logolarının (WWFFontheGO Icon) derlenip projenin App Icon'u olarak Android ve iOS sistem dosyalarına eklenmesi.
- Son kullanıcıya hazır, hatasız APK veya AppBundle inşası (Release Build).
