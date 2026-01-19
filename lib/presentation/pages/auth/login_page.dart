import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _loginCard(context),
          ],
        ),
      ),
    );
  }

  /// HEADER
  Widget _header() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFFE082),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'SIMUKA',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: Color(0xFF424242),
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Sistem Informasi Manajemen Unit Kegiatan Mahasiswa Kampus',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF616161),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// CARD LOGIN
  Widget _loginCard(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -50),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Masuk menggunakan email / NIM kampus',
                  style: TextStyle(color: Color(0xFF757575)),
                ),
                const SizedBox(height: 24),

                _inputField(
                  controller: emailController,
                  label: 'Email / NIM',
                  icon: Icons.person_outline,
                  validator: (v) =>
                      v!.isEmpty ? 'Email tidak boleh kosong' : null,
                ),

                const SizedBox(height: 16),

                _inputField(
                  controller: passwordController,
                  label: 'Password',
                  icon: Icons.lock_outline,
                  obscure: true,
                  validator: (v) =>
                      v!.length < 6 ? 'Password minimal 6 karakter' : null,
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF176),
                      foregroundColor: const Color(0xFF424242),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// TEXT FIELD
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFFFFE082)),
        filled: true,
        fillColor: const Color(0xFFFFFDE7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
