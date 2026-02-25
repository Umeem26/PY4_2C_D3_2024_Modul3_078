import 'package:flutter/material.dart';
import 'dart:async';
import 'login_controller.dart';
import '../logbook/log_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _controller = LoginController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isObscure = true;
  int _failedAttempts = 0;
  bool _isLocked = false;
  int _lockCountdown = 0;
  Timer? _timer;

  void _handleLogin() {
    if (_isLocked) return;

    String user = _userController.text;
    String pass = _passController.text;

    if (_controller.login(user, pass)) {
      _failedAttempts = 0;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogView(username: user)),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Login Berhasil!"),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else {
      setState(() {
        _failedAttempts++;
        if (_failedAttempts >= 3) {
          _startLockout();
        }
      });

      if (!_isLocked) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Username atau Password salah! (Percobaan $_failedAttempts/3)"),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  void _startLockout() {
    _isLocked = true;
    _lockCountdown = 10;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Terlalu banyak percobaan. Tunggu 10 detik."),
        backgroundColor: Colors.orange.shade800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_lockCountdown > 1) {
          _lockCountdown--;
        } else {
          _isLocked = false;
          _failedAttempts = 0;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_person_rounded, size: 80, color: Colors.indigo.shade600),
                  const SizedBox(height: 20),
                  const Text(
                    "Login Gatekeeper",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _userController,
                    enabled: !_isLocked,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passController,
                    obscureText: _isObscure,
                    enabled: !_isLocked,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLocked ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isLocked ? Colors.grey : Colors.indigo.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                      ),
                      child: Text(
                        _isLocked ? "Tunggu $_lockCountdown detik" : "Masuk",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}