import 'package:flutter/material.dart';
import 'detail_kegiatan_pages.dart';
import 'anggota_page.dart'; // Import halaman anggota yang tadi dibuat

class KegiatanPage extends StatelessWidget {
  final String ukmName; 

  const KegiatanPage({super.key, required this.ukmName});

  @override
  Widget build(BuildContext context) {
    // 1. Tambahkan 'Data Anggota' ke dalam list menu
    final List<Map<String, dynamic>> menuFitur = [
      {'nama': 'Latihan Rutin', 'icon': Icons.calendar_today},
      {'nama': 'Rapat Kerja', 'icon': Icons.assignment},
      {'nama': 'Event / Lomba', 'icon': Icons.emoji_events},
      {'nama': 'Data Anggota', 'icon': Icons.people_alt_rounded}, // Fitur baru
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu $ukmName'),
        backgroundColor: const Color(0xFFFFE082),
        foregroundColor: const Color(0xFF424242),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuFitur.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFFFF9C4),
                child: Icon(menuFitur[index]['icon'], color: Colors.orange),
              ),
              title: Text(
                menuFitur[index]['nama'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Kelola ${menuFitur[index]['nama']} $ukmName'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              
              onTap: () {
                // 2. Logika Navigasi: Cek nama menu yang diklik
                if (menuFitur[index]['nama'] == 'Data Anggota') {
                  // Jika yang diklik Data Anggota, pergi ke halaman Anggota
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnggotaPage(ukmName: ukmName),
                    ),
                  );
                } else {
                  // Jika yang diklik lainnya, pergi ke halaman Detail Kegiatan
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