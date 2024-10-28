import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysmk_prakerin/router/router_name.dart';
import 'package:mysmk_prakerin/service/auth_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool _obscurePassword = true;
  bool isloading = false;

  void actionLogin() {
    if (emailController.text != "" && passController.text != "") {
      setState(() {
        isloading = !isloading;
      });
      AuthService()
          .prosesLogin(emailController.text, passController.text)
          .then((value) {
        setState(() {
          if (value is! String) {
            print("berhasil");
            setState(() {
              isloading = !isloading;
            });
            // Navigator.pushReplacementNamed(context, '/Dashboard',
            //     arguments: value);
            context.goNamed(Routes.main, extra: value);
          } else {
            gagalLogin(value);
            setState(() {
              isloading = !isloading;
            });
          }
        });
      });
    } else {
      gagalLogin("Harap Masukkan Email & Password dengan benar");
    }
  }

  void gagalLogin(String pesan) {
    Alert(
        context: context,
        title: "Login Gagal",
        desc: pesan,
        type: AlertType.error,
        buttons: [
          DialogButton(
              color: Colors.red,
              // ignore: prefer_const_constructors
              child: Text("OK",
                  style: const TextStyle(color: Colors.white, fontSize: 26)),
              onPressed: () {
                context.pop();
              })
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset('images/logoMysmk.png', height: 120),
              const SizedBox(height: 40),

              // Email input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Masukkan email anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.email),
                      contentPadding: const EdgeInsets.all(15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Password input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: passController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Masukkan password anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      contentPadding: const EdgeInsets.all(15),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Login button
              SizedBox(
                width: lebar,
                child: ElevatedButton(
                  onPressed: () {
                    actionLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: isloading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Masuk',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              TextButton(
                onPressed: () => {},
                child: const Text('Lupa password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
