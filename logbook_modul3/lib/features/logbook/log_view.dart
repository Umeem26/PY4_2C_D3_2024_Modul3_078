import 'package:flutter/material.dart';

class LogView extends StatelessWidget {
  final String username;
  const LogView({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Logbook: $username")),
      body: const Center(child: Text("Halaman Logbook Modul 3")),
    );
  }
}