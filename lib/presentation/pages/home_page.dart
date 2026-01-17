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

  int _currentIndex = 0;

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
    // Tentukan Judul AppBar dinamis
    String title = 'Dashboard SIMUKA';
    if (_currentIndex == 1) title = 'Jadwal Kegiatan UKM';
    if (_currentIndex == 2) title = 'Notifikasi';
    if (_currentIndex == 3) title = 'Profil Pengguna'; 

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFE082),
        centerTitle: true,
        elevation: 0,
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
        selectedItemColor: const Color(0xFFFBC02D),
        unselectedItemColor: Colors.grey,
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
      case 1:
        return _buildJadwalPage();
      case 2:
        return _buildNotifikasiPage(); 
      case 3:
        return _buildProfilPage();     
      default:
        return _buildDashboardHome();
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
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(dataJadwal[index]['jam']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Text("WIB", style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              const VerticalDivider(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dataJadwal[index]['ukm']!, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(dataJadwal[index]['kegiatan']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(dataJadwal[index]['tgl']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26),
            ],
          ),
        );
      },
    );
  }

  // --- 2. HALAMAN NOTIFIKASI ---
  Widget _buildNotifikasiPage() {
    final List<Map<String, dynamic>> listNotif = [
      {'title': 'Pendaftaran Berhasil', 'msg': 'Selamat! Kamu resmi bergabung di UKM E-sports.', 'time': '2 jam lalu', 'icon': Icons.check_circle, 'color': Colors.green},
      {'title': 'Jadwal Diubah', 'msg': 'Latihan Futsal dimajukan menjadi tanggal 1 Februari 2026', 'time': '5 jam lalu', 'icon': Icons.warning_amber_rounded, 'color': Colors.orange},
      {'title': 'Event Mendatang', 'msg': 'Jangan lewatkan Turnamen MLBB minggu depan!', 'time': '1 hari lalu', 'icon': Icons.event, 'color': Colors.blue},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: listNotif.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.black12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: listNotif[index]['color'].withOpacity(0.1),
              child: Icon(listNotif[index]['icon'], color: listNotif[index]['color']),
            ),
            title: Text(listNotif[index]['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
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
          const Center(
            child: Stack(
              children: [
                CircleAvatar(radius: 55, backgroundColor: Color(0xFFFFE082), child: CircleAvatar(radius: 50, backgroundColor: Colors.white, child: Icon(Icons.person, size: 60, color: Colors.grey))),
                Positioned(bottom: 0, right: 0, child: CircleAvatar(radius: 18, backgroundColor: Colors.orange, child: Icon(Icons.edit, size: 16, color: Colors.white))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text("Nama Pengguna", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFE082), foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
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
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
    );
  }

  // --- 4. DASHBOARD (ASLI) ---
  Widget _buildDashboardHome() {
    return SingleChildScrollView(
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

  // --- BAGIAN DRAWER YANG DIPERBAIKI (HOME DIHAPUS) ---
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(children: [
        const UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Color(0xFFFFE082)),
          accountName: Text('Admin UKM', style: TextStyle(color: Colors.black)),
          accountEmail: Text('admin@simuka.id', style: TextStyle(color: Colors.black)),
          currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person)),
        ),
        // Menu Home sudah dihapus dari sini agar tidak redundan
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