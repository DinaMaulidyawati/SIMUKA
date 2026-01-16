import 'package:flutter/material.dart';
import 'kegiatan_pages.dart';
import 'app_state.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Fungsi refresh saat kembali dari halaman detail
  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> daftarUkm = [
      {'name': 'E-sports', 'icon': Icons.sports_esports},
      {'name': 'PSHT', 'icon': Icons.sports_martial_arts},
      {'name': 'Futsal', 'icon': Icons.sports_soccer},
      {'name': 'Pencinta Alam', 'icon': Icons.terrain},
      {'name': 'Basket', 'icon': Icons.sports_basketball},
      {'name': 'Seni Tari', 'icon': Icons.accessibility_new},
      {'name': 'Taekwondo', 'icon': Icons.kitesurfing},
      {'name': 'Seni Rupa', 'icon': Icons.palette},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard SIMUKA', style: TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFE082),
        centerTitle: true,
        elevation: 0,
      ),
      // Panggil fungsi Drawer di sini
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selamat Datang 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('Kelola UKM Kampus dengan mudah', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            _buildSummarySection(),
            const SizedBox(height: 25),
            const Text('Pilih UKM', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.3),
              itemCount: daftarUkm.length,
              itemBuilder: (context, index) {
                String ukmName = daftarUkm[index]['name'];
                bool hasEvent = AppState.ukmEventStatus[ukmName] ?? false;

                return InkWell(
                  onTap: () async {
                    // Masuk ke Menu Kegiatan (di dalamnya sudah ada menu Anggota)
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => KegiatanPage(ukmName: ukmName)));
                    refresh(); // Refresh saat kembali untuk cek status EVENT!
                  },
                  child: Stack(
                    children: [
                      Card(
                        color: const Color(0xFFFFE082),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(daftarUkm[index]['icon'], size: 40),
                              Text(ukmName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      if (hasEvent)
                        Positioned(
                          top: 10, right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                            child: const Text('EVENT!', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Row(
      children: [
        _summaryCard('Anggota', '120'),
        const SizedBox(width: 10),
        _summaryCard('Kegiatan', '24'),
        const SizedBox(width: 10),
        _summaryCard('Event', '5'),
      ],
    );
  }

  Widget _summaryCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.yellow[50], borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ]),
      ),
    );
  }

  // ================= DRAWER YANG SUDAH DIPERBAIKI =================
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(children: [
        // Header Profil
        const UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Color(0xFFFFE082)),
          accountName: Text('Admin UKM', style: TextStyle(color: Colors.black)),
          accountEmail: Text('admin@simuka.id', style: TextStyle(color: Colors.black)),
          currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person)),
        ),
        
        // Menu Home
        ListTile(
          leading: const Icon(Icons.home), 
          title: const Text('Home'), 
          onTap: () => Navigator.pop(context)
        ),
        
        // Menu Pengaturan
        ListTile(
          leading: const Icon(Icons.settings), 
          title: const Text('Pengaturan'), 
          onTap: () {}
        ),

        // === MENU TENTANG APLIKASI (UPDATED) ===
        ListTile(
          leading: const Icon(Icons.info_outline), 
          title: const Text('Tentang Aplikasi'), 
          onTap: () {
            // Tutup drawer dulu biar rapi
            Navigator.pop(context);

            // Tampilkan Dialog berisi teks deskripsi SIMUKA
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  title: const Text("Tentang SIMUKA", style: TextStyle(fontWeight: FontWeight.bold)),
                  content: const SingleChildScrollView(
                    child: Text(
                      '''SIMUKA (Sistem Informasi Manajemen Unit Kegiatan Mahasiswa) merupakan aplikasi yang dirancang untuk mendukung pengelolaan dan pengembangan Unit Kegiatan Mahasiswa (UKM) secara terintegrasi.
                      Aplikasi ini menjadi wadah dalam pencatatan, pengelolaan, dan pemantauan seluruh kegiatan UKM. Melalui SIMUKA, pengguna dapat melihat informasi kegiatan, memantau perkembangan UKM dari waktu ke waktu, serta mengelola data organisasi secara lebih terstruktur.
                      Dengan adanya SIMUKA, diharapkan setiap UKM dapat berkembang secara berkelanjutan dan meningkatkan kualitas aktivitas kemahasiswaan di lingkungan kampus.''',
                      textAlign: TextAlign.justify, // Biar teksnya rata kanan-kiri rapi
                      style: TextStyle(fontSize: 14, height: 1.5), // Spasi antar baris enak dibaca
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Tutup", style: TextStyle(color: Colors.orange)),
                    ),
                  ],
                );
              },
            );
          }
        ),

        // Spacer biar Log Out kedorong ke bawah
        const Spacer(),
        
        const Divider(),
        
        // Menu Log Out (Tetap aman di bawah!)
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red), 
          title: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), 
          onTap: () {
             Navigator.pop(context);
             // Tambahin logika logout di sini nanti
          }
        ),
        
          const SizedBox(height: 20),
        ]),
      );
    }
  }