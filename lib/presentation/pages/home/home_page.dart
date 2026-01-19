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

  // Palet Warna Baru
  final Color clrBg = const Color(0xFFF0F3FA);
  final Color clrLightBlue = const Color(0xFFD5DEEF);
  final Color clrAccentBlue = const Color(0xFFB1C9EF);
  final Color clrSoftBlue = const Color(0xFF8AAEE0);
  final Color clrPrimaryBlue = const Color(0xFF628ECB);
  final Color clrDarkBlue = const Color(0xFF395886);

  final List<Map<String, dynamic>> daftarUkm = [
    {'name': 'E-sports', 'icon': Icons.sports_esports, 'color': const Color(0xFFD5DEEF)},
    {'name': 'PSHT', 'icon': Icons.sports_martial_arts, 'color': const Color(0xFFB1C9EF)},
    {'name': 'Futsal', 'icon': Icons.sports_soccer, 'color': const Color(0xFF8AAEE0)},
    {'name': 'Pencinta Alam', 'icon': Icons.terrain, 'color': const Color(0xFFD5DEEF)},
    {'name': 'Basket', 'icon': Icons.sports_basketball, 'color': const Color(0xFFB1C9EF)},
    {'name': 'Seni Tari', 'icon': Icons.accessibility_new, 'color': const Color(0xFF8AAEE0)},
    {'name': 'Taekwondo', 'icon': Icons.kitesurfing, 'color': const Color(0xFFD5DEEF)},
    {'name': 'Seni Rupa', 'icon': Icons.palette, 'color': const Color(0xFFB1C9EF)},
  ];

  @override
  Widget build(BuildContext context) {
    String title = 'Dashboard SIMUKA';
    if (_currentIndex == 1) title = 'Jadwal Kegiatan UKM';
    if (_currentIndex == 2) title = 'Notifikasi';
    if (_currentIndex == 3) title = 'Profil Pengguna'; 

    return Scaffold(
      backgroundColor: clrBg,
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: clrBg, fontWeight: FontWeight.bold)),
        backgroundColor: clrDarkBlue,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: clrBg),
      ),
      drawer: _buildDrawer(context),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: clrDarkBlue,
        unselectedItemColor: clrSoftBlue,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Jadwal'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifikasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),

      body: _buildCurrentPage(),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 1: return _buildJadwalPage();
      case 2: return _buildNotifikasiPage(); 
      case 3: return _buildProfilPage();     
      default: return _buildDashboardHome();
    }
  }

  // --- 1. HALAMAN JADWAL ---
  Widget _buildJadwalPage() {
    final List<Map<String, String>> dataJadwal = [
      {'ukm': 'Futsal', 'jam': '16:00', 'tgl': 'Senin, 19 Jan', 'kegiatan': 'Latihan Rutin'},
      {'ukm': 'E-sports', 'jam': '19:00', 'tgl': 'Selasa, 20 Jan', 'kegiatan': 'Sparing MLBB'},
      {'ukm': 'Seni Tari', 'jam': '15:00', 'tgl': 'Rabu, 21 Jan', 'kegiatan': 'Latihan Koreo'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dataJadwal.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: clrLightBlue),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(dataJadwal[index]['jam']!, style: TextStyle(fontWeight: FontWeight.bold, color: clrDarkBlue)),
                  Text("WIB", style: TextStyle(fontSize: 10, color: clrSoftBlue)),
                ],
              ),
              VerticalDivider(width: 30, color: clrLightBlue),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dataJadwal[index]['ukm']!, style: TextStyle(color: clrPrimaryBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(dataJadwal[index]['kegiatan']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: clrDarkBlue)),
                    Text(dataJadwal[index]['tgl']!, style: TextStyle(color: clrSoftBlue, fontSize: 12)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14, color: clrLightBlue),
            ],
          ),
        );
      },
    );
  }

  // --- 2. HALAMAN NOTIFIKASI ---
  Widget _buildNotifikasiPage() {
    final List<Map<String, dynamic>> listNotif = [
      {'title': 'Pendaftaran Berhasil', 'msg': 'Selamat! Kamu resmi bergabung di UKM E-sports.', 'time': '2 jam lalu', 'icon': Icons.check_circle, 'color': clrPrimaryBlue},
      {'title': 'Jadwal Diubah', 'msg': 'Latihan Futsal dimajukan menjadi tanggal 1 Februari 2026', 'time': '5 jam lalu', 'icon': Icons.warning_amber_rounded, 'color': clrDarkBlue},
      {'title': 'Event Mendatang', 'msg': 'Jangan lewatkan Turnamen MLBB minggu depan!', 'time': '1 hari lalu', 'icon': Icons.event, 'color': clrSoftBlue},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: listNotif.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: clrLightBlue)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: listNotif[index]['color'].withOpacity(0.1),
              child: Icon(listNotif[index]['icon'], color: listNotif[index]['color']),
            ),
            title: Text(listNotif[index]['title'], style: TextStyle(fontWeight: FontWeight.bold, color: clrDarkBlue)),
            subtitle: Text(listNotif[index]['msg']),
            trailing: Text(listNotif[index]['time'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ),
        );
      },
    );
  }

  // --- 3. HALAMAN PROFIL ---
  Widget _buildProfilPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Stack(
              children: [
                CircleAvatar(radius: 55, backgroundColor: clrAccentBlue, child: CircleAvatar(radius: 50, backgroundColor: Colors.white, child: Icon(Icons.person, size: 60, color: clrSoftBlue))),
                Positioned(bottom: 0, right: 0, child: CircleAvatar(radius: 18, backgroundColor: clrDarkBlue, child: const Icon(Icons.edit, size: 16, color: Colors.white))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text("Nama Pengguna", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: clrDarkBlue)),
          const Text("20230104001", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 25),
          _buildProfilTile(Icons.email_outlined, "Email", "user@simuka.id"),
          _buildProfilTile(Icons.phone_android, "No. Telepon", "0812-3456-7890"),
          _buildProfilTile(Icons.school_outlined, "Program Studi", "Teknik Informatika"),
          _buildProfilTile(Icons.verified_user_outlined, "Status Akun", "Aktif"),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: clrPrimaryBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("Edit Informasi Profil", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: clrPrimaryBlue),
      title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: clrDarkBlue)),
    );
  }

  // --- 4. DASHBOARD ---
  Widget _buildDashboardHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Coming Soon ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: clrDarkBlue)),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildEventCard("Turnamen Mobile Legends", "25 Jan 2026", clrAccentBlue, true),
                _buildEventCard("Lomba Tari Tradisional", "02 Feb 2026", clrLightBlue, true),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Event Terlaksana ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: clrDarkBlue)),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildEventCard("Futsal Cup 2025", "Selesai", Colors.white, false),
                _buildEventCard("Diklat Alam XV", "Selesai", Colors.white, false),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Text('Pilih UKM', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: clrDarkBlue)),
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
                  await Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => KegiatanPage(
                        ukmName: ukmName, 
                        themeColor: ukmColor,
                      ),
                    ),
                  );
                  refresh();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ukmColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: clrLightBlue, width: 0.5),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(daftarUkm[index]['icon'], size: 40, color: clrDarkBlue),
                            Text(ukmName, style: TextStyle(fontWeight: FontWeight.bold, color: clrDarkBlue)),
                          ],
                        ),
                      ),
                      if (hasEvent)
                        Positioned(
                          top: 10, right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
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
    );
  }

  Widget _buildEventCard(String title, String status, Color color, bool isBig) {
    return Container(
      width: isBig ? 240 : 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: clrLightBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: clrDarkBlue)),
          const SizedBox(height: 4),
          Text(status, style: TextStyle(color: clrDarkBlue.withOpacity(0.7), fontSize: 12)),
        ],
      ),
    );
  }

  // --- DRAWER ---
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: clrBg,
      child: Column(children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: clrDarkBlue),
          accountName: Text('Admin UKM', style: TextStyle(color: clrBg)),
          accountEmail: Text('admin@simuka.id', style: TextStyle(color: clrBg)),
          currentAccountPicture: CircleAvatar(backgroundColor: clrBg, child: Icon(Icons.person, color: clrDarkBlue)),
        ),
        ListTile(
          leading: Icon(Icons.settings, color: clrDarkBlue), 
          title: Text('Pengaturan', style: TextStyle(color: clrDarkBlue)), 
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PengaturanPage()));
          }
        ),
        ListTile(
          leading: Icon(Icons.info_outline, color: clrDarkBlue), 
          title: Text('Tentang Aplikasi', style: TextStyle(color: clrDarkBlue)), 
          onTap: () {
            Navigator.pop(context);
            // ... dialog code ...
          }
        ),
        const Spacer(),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red), 
          title: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), 
          onTap: () {
            // ... logout code ...
          }
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}