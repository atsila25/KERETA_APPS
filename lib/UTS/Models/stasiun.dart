class Stasiun {
  final int id;
  final String nama;
  final String jenisPerjalanan;

  Stasiun({
    required this.id,
    required this.nama,
    required this.jenisPerjalanan,
  });

  factory Stasiun.fromJson(Map<String, dynamic> json) {
    return Stasiun(
      id: json['id'],
      nama: json['nama'],
      jenisPerjalanan: json['jenis_perjalanan'],
    );
  }
}
