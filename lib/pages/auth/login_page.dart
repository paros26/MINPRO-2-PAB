import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../home/home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> login() async {

    setState(() {
      isLoading = true;
    });

    try {

      await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>  HomePage(),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login gagal"),
        ),
      );

    }

    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),

      body: Center(
        child: Card(

          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          child: Container(
            width: 350,
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Text(
                  "Login Aplikasi LPG",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),

                    onPressed: isLoading ? null : login,

                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("LOGIN"),

                  ),
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    );

                  },
                  child: const Text("Belum punya akun? Register"),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}