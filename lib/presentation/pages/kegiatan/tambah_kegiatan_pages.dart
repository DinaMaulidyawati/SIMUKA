import 'package:flutter/material.dart';

class TambahKegiatanPage extends StatefulWidget {
  const TambahKegiatanPage({super.key});

  @override
  State<TambahKegiatanPage> createState() => _TambahKegiatanPageState();
}

class _TambahKegiatanPageState extends State<TambahKegiatanPage> {
  // Controller untuk ambil teks dari inputan
  final TextEditingController namaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kegiatan', style: TextStyle(color: Color(0xFF424242))),
        backgroundColor: const Color(0xFFFFE082),
        foregroundColor: const Color(0xFF424242),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaController, // HUBUNGKAN CONTROLLER
              decoration: InputDecoration(
                labelText: 'Nama Kegiatan',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: deskripsiController, // HUBUNGKAN CONTROLLER
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE082),
                  foregroundColor: const Color(0xFF424242),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // LOGIKA BALIKIN DATA:
                  // Kirim data kembali ke halaman sebelumnya dalam bentuk Map
                  if (namaController.text.isNotEmpty) {
                    Navigator.pop(context, {
                      'nama': namaController.text,
                      'deskripsi': deskripsiController.text,
                    });
                  }
                },
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}