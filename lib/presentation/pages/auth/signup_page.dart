import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Untuk indikator loading
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  // Controllers
  final nama = TextEditingController();
  final email = TextEditingController();
  final nim = TextEditingController();
  final fakultas = TextEditingController();
  final jurusan = TextEditingController();
  final tahunMasuk = TextEditingController();
  final password = TextEditingController();
  final ulangiPassword = TextEditingController();

  // Warna Tema Biru Profesional
  final Color colorDarkBlue = const Color(0xFF395886);
  final Color colorPrimaryBlue = const Color(0xFF628ECB);
  final Color colorBg = const Color(0xFFF0F3FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        title: const Text("Pendaftaran Akun", 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: colorDarkBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _field(nama, "Nama Lengkap", Icons.person_outline),
                  _field(email, "Email", Icons.email_outlined, emailField: true),
                  _field(nim, "NIM (10 digit)", Icons.badge_outlined, number: true),
                  _field(fakultas, "Fakultas", Icons.business_outlined),
                  _field(jurusan, "Jurusan", Icons.school_outlined),
                  _field(tahunMasuk, "Tahun Masuk", Icons.calendar_today_outlined, number: true),
                  _field(password, "Password", Icons.lock_outline, obscure: true, isPassField: true),
                  _field(ulangiPassword, "Ulangi Password", Icons.lock_clock_outlined, obscure: true, isConfirmField: true),
                  const SizedBox(height: 30),
                  _buildRegisterButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          // Indikator Loading saat proses Firebase berjalan
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(Icons.person_add_rounded, size: 80, color: colorDarkBlue),
        const SizedBox(height: 10),
        Text("Daftar Akun Baru", 
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorDarkBlue)),
        const Text("Lengkapi data diri Anda untuk bergabung", 
          style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorDarkBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
        onPressed: _isLoading ? null : daftar,
        child: const Text("DAFTAR SEKARANG", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  Future<void> daftar() async {
    if (!formKey.currentState!.validate()) return;

    if (password.text != ulangiPassword.text) {
      _showError("Konfirmasi password tidak cocok");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Buat User di Firebase Auth
      final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // 2. Simpan Data ke Firestore
      // UID dokumen HARUS sama dengan UID Auth agar sesuai Security Rules
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCred.user!.uid)
          .set({
        "uid": userCred.user!.uid,
        "nama": nama.text.trim(),
        "email": email.text.trim(),
        "nim": nim.text.trim(),
        "fakultas": fakultas.text.trim(),
        "jurusan": jurusan.text.trim(),
        "tahunMasuk": tahunMasuk.text.trim(),
        "role": "anggota",
        "createdAt": FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pendaftaran Berhasil! Silahkan Login.")),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "Terjadi kesalahan pendaftaran");
    } catch (e) {
      _showError("Gagal menyimpan data ke database. Cek aturan Firebase Rules Anda.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  Widget _field(
    TextEditingController c,
    String label,
    IconData icon, {
    bool obscure = false,
    bool emailField = false,
    bool number = false,
    bool isPassField = false,
    bool isConfirmField = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: c,
        obscureText: obscure ? (isPassField ? _obscurePass : _obscureConfirm) : false,
        keyboardType: number ? TextInputType.number : (emailField ? TextInputType.emailAddress : TextInputType.text),
        validator: (v) {
          if (v == null || v.isEmpty) return "$label wajib diisi";
          if (label.contains("NIM") && v.length != 10) return "NIM harus 10 digit angka";
          if (emailField && (!v.contains("@") || !v.contains("."))) return "Format email tidak valid";
          if (obscure && v.length < 6) return "Password minimal 6 karakter";
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: colorPrimaryBlue),
          suffixIcon: obscure 
            ? IconButton(
                icon: Icon( (isPassField ? _obscurePass : _obscureConfirm) ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    if (isPassField) _obscurePass = !_obscurePass;
                    if (isConfirmField) _obscureConfirm = !_obscureConfirm;
                  });
                },
              )
            : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
      ),
    );
  }
}