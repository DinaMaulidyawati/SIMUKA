import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard SIMUKA'),
        backgroundColor: const Color(0xFFFF8A65),
      ),
      body: const Center(
        child: Text(
          'Login berhasil 🎉\nSIMUKA siap digunakan',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
