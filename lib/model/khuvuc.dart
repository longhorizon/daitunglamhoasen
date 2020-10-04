class KhuVuc{
  int id;
  String tenkhuvuc;
  int succhua;
  String doituong;
  String mota;

  KhuVuc({
    this.id,
    this.tenkhuvuc,
    this.succhua,
    this.doituong,
    this.mota,
});
  factory KhuVuc.fromJson(Map<String,dynamic> json) {
    return KhuVuc(
      id: int.parse(json['id']),
      tenkhuvuc: json['tenkhuvuc'],
      succhua: int.parse(json['succhua']),
      doituong: json['doituong'],
      mota: json['mota'],
    );
  }
}