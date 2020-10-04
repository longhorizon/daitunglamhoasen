import 'dart:convert';
import 'dart:io';
import 'package:admin/model/thanhVien.dart';
import 'package:admin/model/user.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import '../app_theme/app_theme.dart';
import '../app_theme/fintness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThongTinThanhVienScreen extends StatefulWidget {
  ThongTinThanhVienScreen({this.user, this.tv, this.url});
  User user;
  ThanhVien tv;
  final String url;
  @override
  ThanhVienState createState() => ThanhVienState();
}

enum GioiTinh { nam, nu }

class ThanhVienState extends State<ThongTinThanhVienScreen> {
  Future<File> file;
  Future<File> filecmnd1;
  Future<File> filecmnd2;
  String status = '';
  String base64Image;
  String cmnd1;
  String cmnd2;
  File tmpFile;
  File tmpFile1;
  File tmpFile2;
  String errMessage = 'Error Uploading Image';
  bool flag = false;
  GioiTinh _gioitinh = GioiTinh.nam;

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }
  chonCMND1() {
    setState(() {
      filecmnd1 = _scanBytes();
    });
  }
  chonCMND2() {
    setState(() {
      filecmnd2 = _scanBytes();
    });
  }

  TextEditingController hoten = TextEditingController();
  TextEditingController phapdanh = TextEditingController();
  TextEditingController ngaysinh = TextEditingController();
  TextEditingController noidkhk = TextEditingController();
  TextEditingController cmnd = TextEditingController();
  TextEditingController ngaycap = TextEditingController();
  TextEditingController noicap = TextEditingController();
  TextEditingController nghenghiep = TextEditingController();
  TextEditingController tinhtrangthannhan = TextEditingController();
  TextEditingController sodtcanhan = TextEditingController();
  TextEditingController sodtnguoithan = TextEditingController();
  TextEditingController hinhcmnd1 = TextEditingController();
  TextEditingController hinhcmnd2 = TextEditingController();
  TextEditingController ghichu = TextEditingController();
  TextEditingController ngaydk = TextEditingController();
  TextEditingController hinh46 = TextEditingController();
  TextEditingController tinhtrangbenhly = TextEditingController();
  TextEditingController hinhhoso = TextEditingController();
  TextEditingController cmndcongchung = TextEditingController();
  TextEditingController hosodahoantat = TextEditingController();
  @override
  void initState() {
    hoten.text = widget.tv.hoten;
    phapdanh.text = widget.tv.phapdanh;
    ngaysinh.text = widget.tv.ngaysinh;
    this._gioitinh = widget.tv.gioitinh == "Nữ" ? GioiTinh.nu : GioiTinh.nam;
    noidkhk.text = widget.tv.noidkhk;
    cmnd.text = widget.tv.cmnd;
    ngaycap.text = widget.tv.ngaycap;
    noicap.text = widget.tv.noicap;
    nghenghiep.text = widget.tv.nghenghiep;
    tinhtrangthannhan.text = widget.tv.tinhtrangthannhan;
    sodtcanhan.text = widget.tv.sodtcanhan;
    sodtnguoithan.text = widget.tv.sodtnguoithan;
    hinhcmnd1.text = widget.tv.hinhcmnd1;
    hinhcmnd2.text = widget.tv.hinhcmnd2;
    ghichu.text = widget.tv.ghichu;
    tinhtrangbenhly.text = widget.tv.tinhtrangbenhly;
    super.initState();
  }

  @override
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
              width: 250,
              height: 250,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else if (widget.tv.hinh46 != '') {
          String ur = widget.url + '/assets/image/cmnd/' + widget.tv.hinh46;
          return Flexible(
              child: Image.network(
                ur,
              ));
        } else {
          return Flexible(
              child: widget.tv.hinh46 == ""
                  ? Image.asset(
                'assets/images/user.png',
              )
                  : Image.network(
                  widget.url + '/assets/image/cmnd/' + widget.tv.hinh46));
        }
      },
    );
  }

  @override
  Widget showCMND1() {
    return FutureBuilder<File>(
      future: filecmnd1,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile1 = snapshot.data;
          print(tmpFile1);
          cmnd1 = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
              width: 300,
              height: 300,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Lỗi hình ảnh',
            textAlign: TextAlign.center,
          );
        } else if (widget.tv.hinhcmnd1 != '') {
          String ur = widget.url + '/assets/image/cmnd/' + widget.tv.hinhcmnd1;
          return Flexible(
              child: Image.network(
                ur,
              ));
        } else {
          return Text(
            '(trống)',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget showCMND2() {
    return FutureBuilder<File>(
      future: filecmnd2,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile2 = snapshot.data;
          print(tmpFile1);
          cmnd2 = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
              width: 300,
              height: 300,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else if (widget.tv.hinhcmnd2 != '') {
          String ur = widget.url + '/assets/image/cmnd/' + widget.tv.hinhcmnd2;
          return Flexible(
              child: Image.network(
                ur,
              ));
        } else {
          return Text(
            '(trống)',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  Widget gioitinh() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Giới tính:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: GioiTinh.nam,
                  groupValue: _gioitinh,
                  onChanged: (GioiTinh value) {
                    setState(() {
                      _gioitinh = GioiTinh.nam;
                    });
                  },
                ),
                Text(
                  "Nam    ",
                  style: TextStyle(fontSize: 20),
                ),
                Radio(
                  value: GioiTinh.nu,
                  groupValue: _gioitinh,
                  onChanged: (GioiTinh value) {
                    setState(() {
                      _gioitinh = GioiTinh.nu;
                    });
                  },
                ),
                Text(
                  'Nữ',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          ],
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.grey,
          title: const Text(
            "Thông tin thành viên",
            style: TextStyle(
              fontSize: 22,
              color: AppTheme.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                showImage(),
                OutlineButton(
                  onPressed: chooseImage,
                  child: Text('Đổi ảnh'),
                ),
                SizedBox(height: 20),
                _inforWidget(),
                SizedBox(height: 20),
                OutlineButton(
                  onPressed: () => {
                    chonCMND1(),
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        "Mặt trước cmnd: ",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Icon(Icons.camera_alt),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                showCMND1(),
                SizedBox(height: 20),
                OutlineButton(
                  onPressed: () => {
                    chonCMND2(),
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        "Mặt sau cmnd: ",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Icon(Icons.camera_alt),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                showCMND2(),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (flag) {
              _luu();
            }
            setState(() {
              flag = !flag;
            });
          },
          label: Text(flag == false ? 'Chỉnh sửa thông tin' : 'lưu'),
          backgroundColor: AppTheme.grey,
        ));
  }

  Widget _entryField(String title,
      {bool isPassword = false, TextEditingController cont}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              readOnly: !flag,
              controller: cont,
              obscureText: isPassword,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }

  Widget _inforWidget() {
    return Column(
      children: <Widget>[
        _entryField("Họ tên:", cont: hoten),
        _entryField("Pháp danh:", cont: phapdanh),
        _entryField("Ngày sinh:", cont: ngaysinh),
        gioitinh(),
        _entryField("Nơi dk hộ khẩu:", cont: noidkhk),
        _entryField("Cmnd:", cont: cmnd),
        _entryField("Ngày cấp:", cont: ngaycap),
        _entryField("Nơi cấp:", cont: noicap),
        _entryField("Nghề nghiệp:", cont: nghenghiep),
        _entryField("Tình trạng thân nhân:", cont: tinhtrangthannhan),
        _entryField("Sđt cá nhân:", cont: sodtcanhan),
        _entryField("Sđt người thân:", cont: sodtnguoithan),
        _entryField("Tình trạng bệnh lý:", cont: tinhtrangbenhly),
      ],
    );
  }

  _capNhaptv() async {
    widget.tv.hoten = hoten.text;
    widget.tv.phapdanh = phapdanh.text;
    widget.tv.ngaysinh = ngaysinh.text;
    widget.tv.gioitinh = _gioitinh == GioiTinh.nam ? 'Nam' : 'Nữ';
    widget.tv.noidkhk = noidkhk.text;
    widget.tv.cmnd = cmnd.text;
    widget.tv.ngaycap = ngaycap.text;
    widget.tv.noicap = noicap.text;
    widget.tv.nghenghiep = nghenghiep.text;
    widget.tv.tinhtrangthannhan = tinhtrangthannhan.text;
    widget.tv.sodtcanhan = sodtcanhan.text;
    widget.tv.sodtnguoithan = sodtnguoithan.text;
    widget.tv.tinhtrangbenhly = tinhtrangbenhly.text;
    widget.tv.ghichu = ghichu.text;
  }

  _luu() async {
    String code = widget.tv.code;
    String _hoten = hoten.text;
    String _phapdanh = phapdanh.text;
    String _ngaysinh = ngaysinh.text;
    String _gioitinh1 = _gioitinh == GioiTinh.nam ? 'Nam' : 'Nữ';
    String _noidkhk = noidkhk.text;
    String _cmnd = cmnd.text;
    String _ngaycap = ngaycap.text;
    String _noicap = noicap.text;
    String _nghenghiep = nghenghiep.text;
    String _tinhtrangthannhan = tinhtrangthannhan.text;
    String _sodtcanhan = sodtcanhan.text;
    String _sodtnguoithan = sodtnguoithan.text;
    String _tinhtrangbenhly = tinhtrangbenhly.text;
    String _ghichu = ghichu.text;

    startUpload(tmpFile,'hinh46');
    startUpload(tmpFile,'cmnd1');
    startUpload(tmpFile,'cmnd2');
    // cài đặt tham số PUT request
    String url = widget.url + '/api/app/update_thanhvien?code=' + code;
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"hoten": "$_hoten", "phapdanh": "$_phapdanh", "ngaysinh": "$_ngaysinh", "gioitinh": "$_gioitinh1", "noidkhk": "$_noidkhk","cmnd": "$_cmnd", "ngaycap": "$_ngaycap", "noicap": "$_noicap", "nghenghiep": "$_nghenghiep", "tinhtrangthannhan": "$_tinhtrangthannhan", "sodtcanhan": "$_sodtcanhan", "sodtnguoithan": "$_sodtnguoithan","tinhtrangbenhly": "$_tinhtrangbenhly","ghichu": "$_ghichu"}';
    print(url);
    print(json);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      _capNhaptv();
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cập nhập thành công! '),
            //content: Text("code hoặc số điện thoại của bạn không chính xác"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload(File tmpFile, String key) {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName,key);
    widget.tv.hinh46 = fileName;
  }

  upload(String fileName,String key) async {
    String url = widget.url + '/api/app/update_image?code=' + widget.tv.code;
    http.post(url, body: {
      //j5Fpas69aJaD2h
      "key": key,
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
      print(result.body);
    }).catchError((error) {
      print(error);
    });
    //print(.body);
  }

  Future _scanBytes() async {
    return ImagePicker.pickImage(source: ImageSource.camera);
  }
}