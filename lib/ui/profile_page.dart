import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          'Página de Perfil em construção.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
