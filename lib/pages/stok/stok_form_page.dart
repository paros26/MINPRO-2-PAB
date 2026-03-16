import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StokFormPage extends StatefulWidget {
  const StokFormPage({super.key});

  @override
  State<StokFormPage> createState() => _StokFormPageState();
}

class _StokFormPageState extends State<StokFormPage> {

  final supabase = Supabase.instance.client;

  late final String userId;

  final stokController = TextEditingController();

  int stokSekarang = 0;
  String stokId = "";
  bool loading = true;

  Future loadStok() async {

    final data = await supabase
        .from('stok')
        .select()
        .limit(1)
        .single();

    setState(() {
      stokSekarang = data['jumlah'];
      stokId = data['id'];
      loading = false;
    });

  }

  Future tambahStok() async {

  if (stokController.text.isEmpty) return;

  int tambah = int.parse(stokController.text);

  await supabase.rpc(
    'tambah_stok',
    params: {
      'tambah_jumlah': tambah,
      'uid': userId
    },
  );

  stokController.clear();

  loadStok();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Stok berhasil diperbarui"),
    ),
  );
}

@override
void initState() {
  super.initState();
  userId = supabase.auth.currentUser!.id;
  loadStok();
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      appBar: AppBar(
        title: const Text("Atur Stok"),
        backgroundColor: Colors.green,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [

                  Container(
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
                              "Stok Sekarang",
                              style: TextStyle(color: Colors.white),
                            ),

                            const SizedBox(height:5),

                            Text(
                              "$stokSekarang Tabung",
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
                  ),

                  const SizedBox(height:25),

                  TextField(
                    controller: stokController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Tambah jumlah stok",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height:15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: tambahStok,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical:14),
                      ),
                      child: const Text("Tambah Stok"),
                    ),
                  )

                ],
              ),
            ),
    );
  }
}