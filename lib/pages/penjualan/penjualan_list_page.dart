import 'package:flutter/material.dart';
import '../../services/penjualan_service.dart';
import 'penjualan_form_page.dart';

class PenjualanListPage extends StatefulWidget {
  @override
  State<PenjualanListPage> createState() => _PenjualanListPageState();
}

class _PenjualanListPageState extends State<PenjualanListPage> {

  final service = PenjualanService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Penjualan"),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PenjualanFormPage(),
            ),
          );
        },
      ),

      body: FutureBuilder(
        future: service.getData(),
        builder: (context, snapshot){

          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data as List;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context,index){

              return ListTile(
                title: Text("Jumlah Tabung : ${data[index]['jumlah_tabung']}"),
                subtitle: Text("Tanggal : ${data[index]['tanggal']}"),

                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async{
                    await service.deleteData(data[index]['id']);
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