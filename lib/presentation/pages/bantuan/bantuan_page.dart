import 'package:flutter/material.dart';

class BantuanPage extends StatelessWidget {
  const BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {'tanya': 'Bagaimana cara menambah anggota?', 'jawab': 'Masuk ke menu UKM pilihan Anda, pilih "Data Anggota", lalu tekan tombol "+" di pojok bawah.'},
      {'tanya': 'Cara membuat event baru?', 'jawab': 'Buka menu "Event / Lomba" di UKM terkait, klik tambah, isi detail acara lalu simpan.'},
      {'tanya': 'Lupa password aplikasi?', 'jawab': 'Klik menu Ubah Password di Pengaturan, kirim kode ke email, dan masukkan password baru.'},
      {'tanya': 'Cara logout?', 'jawab': 'Buka drawer (garis tiga) di halaman utama, tombol logout ada di paling bawah.'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Bantuan & FAQ"), backgroundColor: const Color(0xFFFFE082), foregroundColor: Colors.black),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Card(
            child: ExpansionTile(
              title: Text(faqs[index]['tanya']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(faqs[index]['jawab']!),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}