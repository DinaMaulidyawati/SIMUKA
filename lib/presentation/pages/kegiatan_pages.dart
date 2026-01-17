import 'package:flutter/material.dart';
import 'detail_kegiatan_pages.dart';
import 'anggota_page.dart'; // Import halaman anggota yang tadi dibuat

class KegiatanPage extends StatelessWidget {
  final String ukmName;
  final Color themeColor; // Tambahkan parameter warna tema

  const KegiatanPage({super.key, required this.ukmName, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    // List menu tetap lengkap
    final List<Map<String, dynamic>> menuFitur = [
      {'nama': 'Latihan Rutin', 'icon': Icons.calendar_today},
      {'nama': 'Rapat Kerja', 'icon': Icons.assignment},
      {'nama': 'Event / Lomba', 'icon': Icons.emoji_events},
      {'nama': 'Data Anggota', 'icon': Icons.people_alt_rounded},
    ];

    return Scaffold(
      // Background halus senada warna tema
      backgroundColor: themeColor.withOpacity(0.05),
      appBar: AppBar(
        title: Text('Menu $ukmName', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: themeColor, // Warna AppBar mengikuti UKM
        foregroundColor: const Color(0xFF424242),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuFitur.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              // Border tipis pengganti shadow agar tetap flat
              border: Border.all(color: themeColor.withOpacity(0.3), width: 1),
            ),
            child: ListTile(
              leading: CircleAvatar(
                // Warna background ikon mengikuti tema UKM (lebih soft)
                backgroundColor: themeColor.withOpacity(0.2),
                child: Icon(menuFitur[index]['icon'], color: const Color(0xFF424242)),
              ),
              title: Text(
                menuFitur[index]['nama'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Kelola ${menuFitur[index]['nama']} $ukmName'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              
              onTap: () {
                // Logika Navigasi TIDAK DIKURANGI
                if (menuFitur[index]['nama'] == 'Data Anggota') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnggotaPage(ukmName: ukmName),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailKegiatanPage(
                        title: menuFitur[index]['nama'],
                        ukmName: ukmName,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}