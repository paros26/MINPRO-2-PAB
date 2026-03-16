import 'package:flutter/material.dart';
import '../../services/pelanggan_service.dart';

class PelangganFormPage extends StatefulWidget {
  @override
  State<PelangganFormPage> createState() => _PelangganFormPageState();
}

class _PelangganFormPageState extends State<PelangganFormPage> {

  final namaController = TextEditingController();
  final nikController = TextEditingController();

  String kategori = "Rumah Tangga";

  final service = PelangganService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pelanggan"),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 10,
            margin: const EdgeInsets.all(20),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(25),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Text(
                    "Form Pelanggan",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: "Nama Pelanggan",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: nikController,
                    decoration: const InputDecoration(
                      labelText: "NIK",
                      prefixIcon: Icon(Icons.badge),
                    ),
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField(
                    value: kategori,
                    items: const [
                      DropdownMenuItem(
                        value: "Rumah Tangga",
                        child: Text("Rumah Tangga"),
                      ),
                      DropdownMenuItem(
                        value: "Usaha Mikro",
                        child: Text("Usaha Mikro"),
                      ),
                    ],
                    onChanged: (value){
                      setState(() {
                        kategori = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Kategori",
                      prefixIcon: Icon(Icons.category),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text("Simpan"),
                      onPressed: (){

                        int maxTabung =
                        kategori == "Rumah Tangga" ? 3 : 5;

                        service.insertData({
                          "nama": namaController.text,
                          "nik": nikController.text,
                          "kategori": kategori,
                          "max_tabung": maxTabung
                        });

                        Navigator.pop(context);
                      },
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}