import 'package:flutter/material.dart';
import 'kegiatan_pages.dart';
import 'app_state.dart'; 
import 'pengaturan_page.dart'; 
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void refresh() => setState(() {});

  final List<Map<String, dynamic>> daftarUkm = [
    {'name': 'E-sports', 'icon': Icons.sports_esports, 'color': const Color(0xFFE1BEE7)},
    {'name': 'PSHT', 'icon': Icons.sports_martial_arts, 'color': const Color(0xFFFFCCBC)},
    {'name': 'Futsal', 'icon': Icons.sports_soccer, 'color': const Color(0xFFC8E6C9)},
    {'name': 'Pencinta Alam', 'icon': Icons.terrain, 'color': const Color(0xFFB2DFDB)},
    {'name': 'Basket', 'icon': Icons.sports_basketball, 'color': const Color(0xFFFFE0B2)},
    {'name': 'Seni Tari', 'icon': Icons.accessibility_new, 'color': const Color(0xFFF8BBD0)},
    {'name': 'Taekwondo', 'icon': Icons.kitesurfing, 'color': const Color(0xFFB3E5FC)},
    {'name': 'Seni Rupa', 'icon': Icons.palette, 'color': const Color(0xFFFFF9C4)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        title: const Text('Dashboard SIMUKA', style: TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFE082),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Coming Soon ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildEventCard("Turnamen Mobile Legends", "25 Jan 2026", const Color(0xFFFFF59D), true),
                  _buildEventCard("Lomba Tari Tradisional", "02 Feb 2026", const Color(0xFFFFF59D), true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Event Terlaksana ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildEventCard("Futsal Cup 2025", "Selesai", const Color(0xFFF5F5F5), false),
                  _buildEventCard("Diklat Alam XV", "Selesai", const Color(0xFFF5F5F5), false),
                ],
              ),
            ),
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
                Color ukmColor = daftarUkm[index]['color'];
                bool hasEvent = AppState.ukmEventStatus[ukmName] ?? false;

                return InkWell(
                  onTap: () async {
                    // --- BAGIAN YANG DIPERBAIKI (MENAMBAHKAN themeColor) ---
                    await Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => KegiatanPage(
                          ukmName: ukmName, 
                          themeColor: ukmColor, // Tambahkan ini agar tidak error
                        ),
                      ),
                    );
                    // -------------------------------------------------------
                    refresh();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ukmColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black12, width: 0.5),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(daftarUkm[index]['icon'], size: 40, color: const Color(0xFF424242)),
                              Text(ukmName, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF424242))),
                            ],
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(String title, String status, Color color, bool isBig) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Detail: $title"))),
      child: Container(
        width: isBig ? 240 : 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(status, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(children: [
        const UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Color(0xFFFFE082)),
          accountName: Text('Admin UKM', style: TextStyle(color: Colors.black)),
          accountEmail: Text('admin@simuka.id', style: TextStyle(color: Colors.black)),
          currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person)),
        ),
        ListTile(
          leading: const Icon(Icons.home), 
          title: const Text('Home'), 
          onTap: () => Navigator.pop(context)
        ),
        ListTile(
          leading: const Icon(Icons.settings), 
          title: const Text('Pengaturan'), 
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PengaturanPage()));
          }
        ),
        ListTile(
          leading: const Icon(Icons.info_outline), 
          title: const Text('Tentang Aplikasi'), 
          onTap: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                title: const Text("Tentang SIMUKA", style: TextStyle(fontWeight: FontWeight.bold)),
                content: const Text(
                  '''SIMUKA (Sistem Informasi Manajemen Unit Kegiatan Mahasiswa) merupakan aplikasi yang dirancang untuk mendukung pengelolaan dan pengembangan Unit Kegiatan Mahasiswa (UKM) secara terintegrasi.\n\nDengan adanya SIMUKA, diharapkan setiap UKM dapat berkembang secara berkelanjutan.''',
                  textAlign: TextAlign.justify,
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup")),
                ],
              ),
            );
          }
        ),
        const Spacer(),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red), 
          title: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), 
          onTap: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Konfirmasi"),
                content: const Text("Yakin ingin logout?"),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                    }, 
                    child: const Text("Keluar", style: TextStyle(color: Colors.red))
                  ),
                ],
              ),
            );
          }
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}