import '../config/supabase_config.dart';

class PenjualanService {
  final supabase = SupabaseConfig.client;

  Future getData() async {
    return await supabase.from('penjualan').select();
  }

  Future insertData(Map data) async {
    await supabase.from('penjualan').insert(data);
  }

  Future deleteData(String id) async {
    await supabase.from('penjualan').delete().eq('id', id);
  }
}