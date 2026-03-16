import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../pelanggan/pelanggan_form_page.dart';

class PenjualanFormPage extends StatefulWidget {
  const PenjualanFormPage({super.key});

  @override
  State<PenjualanFormPage> createState() => _PenjualanFormPageState();
}

class _PenjualanFormPageState extends State<PenjualanFormPage> {

  final supabase = Supabase.instance.client;

  final nikController = TextEditingController();
  final jumlahController = TextEditingController();

  String? pelangganId;
  String? namaPelanggan;
  String? kategoriPelanggan;

  /// CEK PELANGGAN
  Future cekPelanggan() async {

  final data = await supabase
      .from('pelanggan')
      .select()
      .eq('nik', nikController.text);

  if (data.isEmpty) {

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: const Text("Pelanggan Tidak Ditemukan"),

          content: const Text(
              "NIK belum terdaftar. Silahkan daftarkan pelanggan terlebih dahulu."),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {

                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PelangganFormPage(),
                  ),
                );

              },
              child: const Text("Daftarkan Pelanggan"),
            )

          ],
        );
      },
    );

  } else {

    setState(() {
      pelangganId = data[0]['id'];
      namaPelanggan = data[0]['nama'];
      kategoriPelanggan = data[0]['kategori'];
    });

  }

}

  Future simpanPenjualan() async {

    if (pelangganId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Silahkan cek pelanggan terlebih dahulu")),
      );
      return;
    }

    if (jumlahController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Masukkan jumlah tabung")),
      );
      return;
    }

    int jumlah = int.parse(jumlahController.text);
if (kategoriPelanggan == "Rumah Tangga" && jumlah > 3) {

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Maksimal pembelian Rumah Tangga adalah 3 tabung"),
    ),
  );

  return;
}

if (kategoriPelanggan == "Usaha Mikro" && jumlah > 5) {

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Maksimal pembelian Usaha Mikro adalah 5 tabung"),
    ),
  );

  return;
}

    try {

      final stokData = await supabase
          .from('stok')
          .select()
          .limit(1)
          .single();

      int stokSekarang = stokData['jumlah'];



if (stokSekarang == 0) {

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Stok tabung habis"),
    ),
  );

  return;
}


if (stokSekarang < jumlah) {

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Stok tabung tidak mencukupi"),
    ),
  );

  return;
}

      await supabase
          .from('penjualan')
          .insert({
            "pelanggan_id": pelangganId,
            "jumlah_tabung": jumlah,
            "tanggal": DateTime.now().toIso8601String()
          });

      await supabase
          .from('stok')
          .update({
            "jumlah": stokSekarang - jumlah
          })
          .eq('id', stokData['id']);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Penjualan berhasil")),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error : $e")),
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      appBar: AppBar(
        title: const Text("Catat Penjualan"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(20),

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

              child: Column(
                children: [

                  TextField(
                    controller: nikController,
                    decoration: const InputDecoration(
                      labelText: "Masukkan NIK",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height:10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: cekPelanggan,
                      child: const Text("Cek Pelanggan"),
                    ),
                  ),

                  const SizedBox(height:15),

                  if(namaPelanggan != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              const Icon(Icons.person,color: Colors.green),
                              const SizedBox(width:8),
                              Text(
                                "Nama : $namaPelanggan",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height:5),

                          Row(
                            children: [
                              const Icon(Icons.category,color: Colors.green),
                              const SizedBox(width:8),
                              Text(
                                "Kategori : $kategoriPelanggan",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),

                  const SizedBox(height:20),

                  TextField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Jumlah Tabung",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height:20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(14),
                      ),
                      onPressed: simpanPenjualan,
                      child: const Text(
                        "Simpan Penjualan",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}