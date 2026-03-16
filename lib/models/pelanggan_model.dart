class Pelanggan {
  final String id;
  final String nama;
  final String nik;
  final String kategori;
  final int maxTabung;

  Pelanggan({
    required this.id,
    required this.nama,
    required this.nik,
    required this.kategori,
    required this.maxTabung,
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      id: json['id'],
      nama: json['nama'],
      nik: json['nik'],
      kategori: json['kategori'],
      maxTabung: json['max_tabung'],
    );
  }
}