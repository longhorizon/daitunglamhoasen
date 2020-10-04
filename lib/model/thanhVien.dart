class ThanhVien {
   int id;
   int iddaotrang;
   String code;
   String hoten;
   String phapdanh;
   String ngaysinh;
   String gioitinh;
   String noidkhk;
   String cmnd;
   String ngaycap;
   String noicap;
   String nghenghiep;
   String tinhtrangthannhan;
   String sodtcanhan;
   String sodtnguoithan;
   String hinhcmnd1;
   String hinhcmnd2;
   String ghichu;
   String ngaydk;
   String active;
   String hinh46;
   String tinhtrangbenhly;
   String hinhhoso;
   String cmndcongchung;
   String hosodahoantat;
   String danghoatdong;
   String dangkytu;
   String danhanthe;
   DateTime ngaynhanthe;

  ThanhVien({
      this.id,
      this.iddaotrang,
      this.code,
      this.hoten,
      this.phapdanh,
      this.ngaysinh,
      this.gioitinh,
      this.noidkhk,
      this.cmnd,
      this.ngaycap,
      this.noicap,
      this.nghenghiep,
      this.tinhtrangthannhan,
      this.sodtcanhan,
      this.sodtnguoithan,
      this.hinhcmnd1,
      this.hinhcmnd2,
      this.ghichu,
      this.ngaydk,
      this.active,
      this.hinh46,
      this.tinhtrangbenhly,
      this.hinhhoso,
      this.cmndcongchung,
      this.hosodahoantat,
      this.danghoatdong,
      this.dangkytu,
      this.danhanthe,
      this.ngaynhanthe  });

  @override
  String toString() {
    return 'ThanhVien{id: $id, iddaotrang: $iddaotrang, code: $code, hoten: $hoten, phapdanh: $phapdanh, ngaysinh: $ngaysinh, gioitinh: $gioitinh, noidkhk: $noidkhk, cmnd: $cmnd, ngaycap: $ngaycap, noicap: $noicap, nghenghiep: $nghenghiep, tinhtrangthannhan: $tinhtrangthannhan, sodtcanhan: $sodtcanhan, sodtnguoithan: $sodtnguoithan, hinhcmnd1: $hinhcmnd1, hinhcmnd2: $hinhcmnd2, ghichu: $ghichu, ngaydk: $ngaydk, active: $active, hinh46: $hinh46, tinhtrangbenhly: $tinhtrangbenhly, hinhhoso: $hinhhoso, cmndcongchung: $cmndcongchung, hosodahoantat: $hosodahoantat, danghoatdong: $danghoatdong, dangkytu: $dangkytu, danhanthe: $danhanthe, ngaynhanthe: $ngaynhanthe}';
  }
   factory ThanhVien.fromJson1(Map<String,dynamic> json) {
     return ThanhVien(
       id: int.parse(json['id']),
       code: json['code'],
       hoten: json['hoten'],);
   }

  factory ThanhVien.fromJson(Map<String,dynamic> json) {
    return ThanhVien(
      id: int.parse(json['id']),
      iddaotrang: int.parse(json['iddaotrang']),
      code: json['code'],
      hoten: json['hoten'],
      phapdanh: json['phapdanh'],
      ngaysinh: json['ngaysinh'],
      gioitinh: json['gioitinh'],
      noidkhk: json['noidkhk'],
      cmnd: json['cmnd'],
      ngaycap: json['ngaycap'],
      noicap: json['noicap'],
      nghenghiep: json['nghenghiep'],
      tinhtrangthannhan: json['tinhtrangthannhan'],
      sodtcanhan: json['sodtcanhan'],
      sodtnguoithan: json['sodtnguoithan'],
      hinhcmnd1: json['hinhcmnd1'],
      hinhcmnd2: json['hinhcmnd2'],
      ghichu: json['ghichu'],
      ngaydk: json['ngaydk'],
      active: json['active'],
      hinh46: json['hinh46'],
      tinhtrangbenhly: json['tinhtrangbenhly'],
      hinhhoso: json['hinhhoso'],
      cmndcongchung: json['cmndcongchung'],
      hosodahoantat: json['hosodahoantat'],
      danghoatdong: json['danghoatdong'],
      dangkytu: json['dangkytu'],
      danhanthe: json['danhanthe'],
      ngaynhanthe: DateTime.parse(json['ngaynhanthe']),
    );
  }
}
