import 'package:flutter/material.dart';
import 'lupa_password_page.dart'; // Import halaman awal ubah password
import 'bantuan_page.dart'; // Import halaman FAQ

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  bool _notifikasiEvent = true;
  bool _notifikasiRapat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7), // Menyesuaikan tema background Home
      appBar: AppBar(
        title: const Text("Pengaturan", style: TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFE082),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF424242)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Akun", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                // MENU EDIT PROFIL DIHAPUS karena sudah ada di Navbar Profil
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: Colors.orange),
                  title: const Text("Ubah Password"),
                  subtitle: const Text("Ganti kata sandi demi keamanan"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // PINDAH KE HALAMAN LUPA PASSWORD (TAHAP 1)
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LupaPasswordPage()));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Notifikasi", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SwitchListTile(
                  activeColor: Colors.orange,
                  secondary: const Icon(Icons.notifications_active_outlined, color: Colors.orange),
                  title: const Text("Notifikasi Event"),
                  value: _notifikasiEvent,
                  onChanged: (val) => setState(() => _notifikasiEvent = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  activeColor: Colors.orange,
                  secondary: const Icon(Icons.calendar_today_outlined, color: Colors.orange),
                  title: const Text("Pengingat Rapat"),
                  value: _notifikasiRapat,
                  onChanged: (val) => setState(() => _notifikasiRapat = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Lainnya", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.orange),
              title: const Text("Bantuan & Dukungan"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // PINDAH KE HALAMAN BANTUAN (FAQ)
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BantuanPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}