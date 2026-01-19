import 'package:flutter/material.dart';
import '../kegiatan/kegiatan_pages.dart';
import '../state/app_state.dart'; 
import '../profile/pengaturan_page.dart'; 
import '../auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void refresh() => setState(() {});

  int _currentIndex = 0;

  // KONFIGURASI PALET WARNA (Sesuai Gambar Referensi)
  static const Color colorBackground = Color(0xFFF0F3FA); // Biru Pucat (Latar belakang utama)
  static const Color colorPrimaryDark = Color(0xFF395886); // Biru Gelap (Teks & Header)
  static const Color colorPrimaryBlue = Color(0xFF628ECB); // Biru Utama (Tombol/Aksen)
  static const Color colorSoftBlue = Color(0xFFB1C9EF);    // Biru Muda (Kartu)
  static const Color colorWhite = Colors.white;

  final List<Map<String, dynamic>> daftarUkm = [
    {'name': 'E-sports', 'icon': Icons.sports_esports, 'color': colorWhite},
    {'name': 'PSHT', 'icon': Icons.sports_martial_arts, 'color': colorWhite},
    {'name': 'Futsal', 'icon': Icons.sports_soccer, 'color': colorWhite},
    {'name': 'Pencinta Alam', 'icon': Icons.terrain, 'color': colorWhite},
    {'name': 'Basket', 'icon': Icons.sports_basketball, 'color': colorWhite},
    {'name': 'Seni Tari', 'icon': Icons.accessibility_new, 'color': colorWhite},
    {'name': 'Taekwondo', 'icon': Icons.kitesurfing, 'color': colorWhite},
    {'name': 'Seni Rupa', 'icon': Icons.palette, 'color': colorWhite},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground, // Latar belakang abu-biru muda seperti gambar
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? 'Dashboard' : (_currentIndex == 1 ? 'Jadwal' : (_currentIndex == 2 ? 'Notifikasi' : 'Profil')),
          style: const TextStyle(color: colorPrimaryDark, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // AppBar transparan agar menyatu dengan latar
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: colorPrimaryDark),
      ),
      drawer: _buildDrawer(context),
      bottomNavigationBar: _buildBottomNav(),
      body: _buildCurrentPage(),
    );
  }

  // --- 1. DASHBOARD (Sesuai gaya gambar referensi) ---
  Widget _buildDashboardHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Selamat datang di,", style: TextStyle(color: colorPrimaryDark, fontSize: 14)),
          const Text("SIMUKA App", style: TextStyle(color: colorPrimaryDark, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          
          // Card Utama (Mirip card "Agus Rukanda" di gambar)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorPrimaryDark,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: colorPrimaryDark.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("1983242342", style: TextStyle(color: colorSoftBlue, fontSize: 12)),
                    Text("Admin SIMUKA", style: TextStyle(color: colorWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Sistem Informasi UKM", style: TextStyle(color: colorWhite, fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: colorWhite.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.stars, color: colorWhite, size: 30),
                )
              ],
            ),
          ),
          
          const SizedBox(height: 25),
          const Text("Menu UKM", style: TextStyle(color: colorPrimaryDark, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 0.8),
            itemCount: daftarUkm.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
                    ),
                    child: Icon(daftarUkm[index]['icon'], color: colorPrimaryBlue),
                  ),
                  const SizedBox(height: 5),
                  Text(daftarUkm[index]['name'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: colorPrimaryDark, fontWeight: FontWeight.w500)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // --- 2. HALAMAN PROFIL (Mirip gaya gambar) ---
  Widget _buildProfilPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundColor: colorSoftBlue,
            child: Icon(Icons.person, size: 50, color: colorWhite),
          ),
          const SizedBox(height: 15),
          const Text("User Account", style: TextStyle(color: colorPrimaryDark, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          
          _buildProfileTile(Icons.email, "Email", "user@simuka.id"),
          _buildProfileTile(Icons.phone, "Telepon", "0812-XXXX-XXXX"),
          
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPrimaryBlue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text("Simpan Perubahan", style: TextStyle(color: colorWhite)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: colorPrimaryBlue),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              Text(value, style: const TextStyle(color: colorPrimaryDark, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  // --- NAVIGATION & DRAWER ---
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          selectedItemColor: colorPrimaryDark,
          unselectedItemColor: colorSoftBlue,
          backgroundColor: colorWhite,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: "Dash"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Jadwal"),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notif"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPage() {
    if (_currentIndex == 3) return _buildProfilPage();
    return _buildDashboardHome(); // Sederhanakan switch untuk contoh ini
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: colorBackground,
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: colorPrimaryDark),
            accountName: Text("SIMUKA Admin"),
            accountEmail: Text("admin@simuka.id"),
          ),
          ListTile(leading: const Icon(Icons.settings, color: colorPrimaryDark), title: const Text("Pengaturan"), onTap: () {}),
        ],
      ),
    );
  }
}