import '../config/supabase_config.dart';

class StokService {
  final supabase = SupabaseConfig.client;

  Future getData() async {
    return await supabase.from('stok').select();
  }

  Future insertData(Map data) async {
    await supabase.from('stok').insert(data);
  }

  Future deleteData(String id) async {
    await supabase.from('stok').delete().eq('id', id);
  }
}