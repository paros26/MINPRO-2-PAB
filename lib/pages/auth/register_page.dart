import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> register() async {

    setState(() {
      isLoading = true;
    });

    try {

      await Supabase.instance.client.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Register berhasil"),
        ),
      );

      Navigator.pop(context);

    } catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Register gagal: $e"), 
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
      appBar: AppBar(
        title: const Text("Register"),
      ),

      body: Center(
        child: Card(

          elevation: 8,

          child: Container(
            width: 350,
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Text(
                  "Buat Akun",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
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

                    onPressed: isLoading ? null : register,

                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("REGISTER"),

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}