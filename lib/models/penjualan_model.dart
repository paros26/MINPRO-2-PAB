class Penjualan {
  final String id;
  final String pelangganId;
  final int jumlahTabung;
  final String tanggal;

  Penjualan({
    required this.id,
    required this.pelangganId,
    required this.jumlahTabung,
    required this.tanggal,
  });

  factory Penjualan.fromJson(Map<String, dynamic> json) {
    return Penjualan(
      id: json['id'],
      pelangganId: json['pelanggan_id'],
      jumlahTabung: json['jumlah_tabung'],
      tanggal: json['tanggal'],
    );
  }
}