import 'package:flutter/material.dart';
import 'input_password_baru_page.dart';

class VerifikasiKodePage extends StatelessWidget {
  const VerifikasiKodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verifikasi Kode"), backgroundColor: const Color(0xFFFFE082), foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Masukkan 6 Digit Kode", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, letterSpacing: 10),
              decoration: InputDecoration(hintText: "000000", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const InputPasswordBaruPage()));
                },
                child: const Text("Verifikasi", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}