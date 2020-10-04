class Khoatu{
   int idctkhoatu;
   String tieude;
   String tomtat;
   String loaikhoatu;
   DateTime ngaybatdautu;
   DateTime ngayketthuctu;
   DateTime ngaybatdaudk;
   DateTime ngayketthucdk;

  Khoatu({
    this.idctkhoatu,
    this.tieude,
    this.tomtat,
    this.loaikhoatu,
    this.ngaybatdautu,
    this.ngayketthuctu,
    this.ngaybatdaudk,
    this.ngayketthucdk});

  factory Khoatu.fromJson(Map<String,dynamic> json) {
    return Khoatu(
      idctkhoatu: int.parse(json['idctkhoatu']),
      tieude: json['tieude'],
      tomtat: json['tomtat'],
      loaikhoatu: json['loaikhoatu'],
      ngaybatdautu: DateTime.parse(json['ngaybatdautu']),
      ngayketthuctu: DateTime.parse(json['ngayketthuctu']),
      ngaybatdaudk: DateTime.parse(json['ngaybatdaudk']),
      ngayketthucdk: DateTime.parse(json['ngayketthucdk']),
    );
  }
}