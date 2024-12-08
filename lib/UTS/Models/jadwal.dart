class Jadwal {
  final int id;
  final String stasiunAsal;
  final String stasiunTujuan;
  final String kereta;
  final String tanggal;
  final String jam;
  final int harga;

  Jadwal({
    required this.id,
    required this.stasiunAsal,
    required this.stasiunTujuan,
    required this.kereta,
    required this.tanggal,
    required this.jam,
    required this.harga,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json['id'],
      stasiunAsal: json['stasiun_asal'],
      stasiunTujuan: json['stasiun_tujuan'],
      kereta: json['kereta'],
      tanggal: json['tanggal'],
      jam: json['jam'],
      harga: json['harga'],
    );
  }
}
