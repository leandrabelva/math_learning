import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _idBimbelController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void _register() async {
    final idBimbel = _idBimbelController.text.trim();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (idBimbel.isEmpty) {
      _showError("ID Bimbel harus diisi.");
      return;
    }
    if (!email.contains('@') || !email.endsWith('.com')) {
      _showError("Email harus mengandung '@' dan diakhiri dengan '.com'.");
      return;
    }
    if (name.length < 5) {
      _showError("Nama harus minimal 5 huruf.");
      return;
    }
    if (password != confirmPassword) {
      _showError("Password dan Konfirmasi Password harus sama.");
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _showSuccess("Registrasi berhasil!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      _showError("Registrasi gagal: ${e.toString()}");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idBimbelController,
              decoration: InputDecoration(labelText: "ID Bimbel"),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nama Lengkap"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: "Konfirmasi Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(child: Text("Selamat datang!")),
    );
  }
}
