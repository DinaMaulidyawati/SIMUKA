import 'package:flutter/material.dart';
import 'verifikasi_kode_page.dart';

class LupaPasswordPage extends StatelessWidget {
  const LupaPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Password"), backgroundColor: const Color(0xFFFFE082), foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Masukkan Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("Kami akan mengirimkan kode verifikasi ke email Anda."),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifikasiKodePage()));
                },
                child: const Text("Kirim Kode", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}