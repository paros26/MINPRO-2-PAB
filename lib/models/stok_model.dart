class Stok {
  final String id;
  final int jumlah;

  Stok({
    required this.id,
    required this.jumlah,
  });

  factory Stok.fromJson(Map<String, dynamic> json) {
    return Stok(
      id: json['id'],
      jumlah: json['jumlah'],
    );
  }
}