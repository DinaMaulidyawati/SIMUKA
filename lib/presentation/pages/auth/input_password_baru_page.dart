import 'package:flutter/material.dart';

class InputPasswordBaruPage extends StatelessWidget {
  const InputPasswordBaruPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Password Baru"), backgroundColor: const Color(0xFFFFE082), foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password Baru", border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Konfirmasi Password Baru", border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock_clock)),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  // Kembali ke pengaturan dan kasih notif sukses
                  Navigator.popUntil(context, (route) => route.isFirst); 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password berhasil diubah!")),
                  );
                },
                child: const Text("Simpan Password", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}