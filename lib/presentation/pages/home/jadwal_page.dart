import 'package:flutter/material.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> semuaJadwal = [
      {'ukm': 'E-sports', 'tgl': '18 Jan 2026', 'jam': '19:00', 'kegiatan': 'Latihan Internal Mobile Legends'},
      {'ukm': 'Futsal', 'tgl': '19 Jan 2026', 'jam': '16:00', 'kegiatan': 'Sparing Antar Jurusan'},
      {'ukm': 'Seni Tari', 'tgl': '20 Jan 2026', 'jam': '15:30', 'kegiatan': 'Latihan Rutin Pendet'},
      {'ukm': 'PSHT', 'tgl': '20 Jan 2026', 'jam': '20:00', 'kegiatan': 'Latihan Fisik & Teknik'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: semuaJadwal.length,
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
              Container(
                width: 60,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE082).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(semuaJadwal[index]['jam']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const Text('WIB', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(semuaJadwal[index]['ukm']!, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(semuaJadwal[index]['kegiatan']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(semuaJadwal[index]['tgl']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}