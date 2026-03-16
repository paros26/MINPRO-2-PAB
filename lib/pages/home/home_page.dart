import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../penjualan/penjualan_form_page.dart';
import '../pelanggan/pelanggan_form_page.dart';
import '../laporan/laporan_page.dart';
import '../stok/stok_form_page.dart';
import '../auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final supabase = Supabase.instance.client;
  late final String userId;

  @override
  void initState() {
    super.initState();
    userId = supabase.auth.currentUser!.id;
    cekStokUser();
  }

  Future<void> cekStokUser() async {

    final data = await supabase
        .from('stok')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (data == null) {

      await supabase.from('stok').insert({
        'jumlah': 0,
        'user_id': userId,
        'tanggal': DateTime.now().toIso8601String()
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Aplikasi Penjualan LPG",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 20),

              StreamBuilder<List<Map<String, dynamic>>>(
                stream: supabase
                    .from('stok')
                    .stream(primaryKey: ['id'])
                    .eq('user_id', userId)
                    .limit(1),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Data stok belum tersedia",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }

                  final stok = snapshot.data![0]['jumlah'];

                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff3a5f0b),
                          Color(0xff6b8e23),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Text(
                              "Stok Tabung",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              "$stok Tabung",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),

                        const Icon(
                          Icons.propane_tank,
                          color: Colors.white,
                          size: 40,
                        )

                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              menuCard(
                icon: Icons.edit_note,
                title: "Catat Penjualan",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PenjualanFormPage(),
                    ),
                  );
                },
              ),

              menuCard(
                icon: Icons.person_add,
                title: "Daftarkan Pelanggan",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PelangganFormPage(),
                    ),
                  );
                },
              ),

              menuCard(
                icon: Icons.bar_chart,
                title: "Laporan Penjualan",
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LaporanPage(),
                    ),
                  );

                },
              ),

              menuCard(
                icon: Icons.settings,
                title: "Atur Stok",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StokFormPage(),
                    ),
                  );
                },
              ),

              const Spacer(),

              Center(
                child: TextButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Keluar dari Aplikasi",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {

                    await supabase.auth.signOut();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    );

                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget menuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.shade200),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black12,
          )
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Icon(icon, color: Colors.green),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.green,
        ),
        onTap: onTap,
      ),
    );
  }
}