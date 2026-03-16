import 'package:flutter/material.dart';
import '../../services/pelanggan_service.dart';
import 'pelanggan_form_page.dart';

class PelangganListPage extends StatefulWidget {
  @override
  State<PelangganListPage> createState() => _PelangganListPageState();
}

class _PelangganListPageState extends State<PelangganListPage> {
  final service = PelangganService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Pelanggan")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PelangganFormPage()),
          );
        },
      ),
      body: FutureBuilder(
        future: service.getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data as List;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]['nama']),
                subtitle: Text(data[index]['nik']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    service.deleteData(data[index]['id']);
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}