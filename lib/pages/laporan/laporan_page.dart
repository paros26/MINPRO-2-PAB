import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {

  final supabase = Supabase.instance.client;

  List dataPenjualan = [];
  bool loading = true;

  int stokSekarang = 0;
  String stokId = "";

  Future loadData() async {

    final stok = await supabase
        .from('stok')
        .select()
        .limit(1)
        .single();

    final data = await supabase
        .from('penjualan')
        .select('''
        id,
        jumlah_tabung,
        tanggal,
        pelanggan (
          nama,
          kategori
        )
        ''')
        .order('tanggal', ascending: false);

    setState(() {
      stokSekarang = stok['jumlah'];
      stokId = stok['id'];
      dataPenjualan = data;
      loading = false;
    });

  }

  Future deletePenjualan(String id, int jumlah) async {

    int stokBaru = stokSekarang + jumlah;

    await supabase
        .from('stok')
        .update({'jumlah': stokBaru})
        .eq('id', stokId);

    await supabase
        .from('penjualan')
        .delete()
        .eq('id', id);

    loadData();
  }

  Future updatePenjualan(
      String id,
      int jumlahLama,
      int jumlahBaru,
      ) async {

    int stokBaru = stokSekarang + jumlahLama - jumlahBaru;

    await supabase
        .from('stok')
        .update({'jumlah': stokBaru})
        .eq('id', stokId);

    await supabase
        .from('penjualan')
        .update({'jumlah_tabung': jumlahBaru})
        .eq('id', id);

    loadData();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      appBar: AppBar(
        title: const Text("Laporan Penjualan"),
        backgroundColor: Colors.green,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dataPenjualan.length,
        itemBuilder: (context, index) {

          final item = dataPenjualan[index];

          return Container(
            margin: const EdgeInsets.only(bottom:15),
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.green.shade200),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  item['pelanggan']['nama'],
                  style: const TextStyle(
                    fontSize:18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Kategori : ${item['pelanggan']['kategori']}",
                ),

                const SizedBox(height:10),

                Text(
                  "Jumlah Tabung : ${item['jumlah_tabung']}",
                ),

                const SizedBox(height:10),

                Row(
                  children: [

                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.green),
                      onPressed: () {

                        final controller = TextEditingController(
                            text: item['jumlah_tabung'].toString());

                        showDialog(
                          context: context,
                          builder: (context) {

                            return AlertDialog(
                              title: const Text("Edit Jumlah Tabung"),

                              content: TextField(
                                controller: controller,
                                keyboardType: TextInputType.number,
                              ),

                              actions: [

                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Batal"),
                                ),

                                ElevatedButton(
                                  onPressed: () {

                                    int jumlahBaru =
                                    int.parse(controller.text);

                                    updatePenjualan(
                                      item['id'],
                                      item['jumlah_tabung'],
                                      jumlahBaru,
                                    );

                                    Navigator.pop(context);

                                  },
                                  child: const Text("Simpan"),
                                )

                              ],
                            );
                          },
                        );

                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {

                        deletePenjualan(
                          item['id'],
                          item['jumlah_tabung'],
                        );

                      },
                    ),

                  ],
                )

              ],
            ),
          );

        },
      ),
    );
  }
}