import '../config/supabase_config.dart';

class PelangganService {
  final supabase = SupabaseConfig.client;

  Future getData() async {
    final data = await supabase.from('pelanggan').select();
    return data;
  }

  Future insertData(Map data) async {
    await supabase.from('pelanggan').insert(data);
  }

  Future updateData(String id, Map data) async {
    await supabase.from('pelanggan').update(data).eq('id', id);
  }

  Future deleteData(String id) async {
    await supabase.from('pelanggan').delete().eq('id', id);
  }
}