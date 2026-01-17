import 'package:flutter/material.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  // Controller untuk inputan
  final TextEditingController _nameController = TextEditingController(text: "Admin UKM");
  final TextEditingController _emailController = TextEditingController(text: "admin@simuka.id");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFE082),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // BAGIAN FOTO PROFIL
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFFFFE082),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=admin'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Logika Image Picker di sini nanti
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // FORM INPUT
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),

            // TOMBOL SIMPAN
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE082),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Logika simpan data
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profil berhasil diperbarui!")),
                  );
                },
                child: const Text("Simpan Perubahan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}