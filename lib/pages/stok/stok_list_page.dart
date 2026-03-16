import 'package:flutter/material.dart';
import '../../services/stok_service.dart';
import 'stok_form_page.dart';

class StokListPage extends StatefulWidget {
  @override
  State<StokListPage> createState() => _StokListPageState();
}

class _StokListPageState extends State<StokListPage> {

  final service = StokService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Stok Tabung")),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StokFormPage(),
            ),
          );
        },
      ),

      body: FutureBuilder(
        future: service.getData(),
        builder: (context,snapshot){

          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data as List;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context,index){

              return ListTile(
                title: Text("Jumlah Stok : ${data[index]['jumlah']}"),

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