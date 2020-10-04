import 'dart:convert';
import 'dart:io';
import 'package:admin/model/thanhVien.dart';
import 'package:admin/ui/admin/timkiem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class updateThanhVien extends StatefulWidget {
  final ThanhVien tv;
  updateThanhVien({
    this.tv
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<updateThanhVien> {

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  bool flag = false;
  bool sua = false;

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }


  TextEditingController hoten = TextEditingController();
  TextEditingController phapdanh = TextEditingController();
  TextEditingController ngaysinh = TextEditingController();
  TextEditingController gioitinh = TextEditingController();
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
    hoten.text=widget.tv.hoten;
    phapdanh.text=widget.tv.phapdanh;
    ngaysinh.text=widget.tv.ngaysinh;
    gioitinh.text=widget.tv.gioitinh;
    noidkhk.text=widget.tv.noidkhk;
    cmnd.text=widget.tv.cmnd;
    ngaycap.text=widget.tv.ngaycap;
    noicap.text=widget.tv.noicap;
    nghenghiep.text=widget.tv.nghenghiep;
    tinhtrangthannhan.text=widget.tv.tinhtrangthannhan;
    sodtcanhan.text=widget.tv.sodtcanhan;
    sodtnguoithan.text=widget.tv.sodtnguoithan;
    hinhcmnd1.text=widget.tv.hinhcmnd1;
    hinhcmnd2.text=widget.tv.hinhcmnd2;
    ghichu.text=widget.tv.ghichu;
    tinhtrangbenhly.text=widget.tv.tinhtrangbenhly;
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
              width: 300,
              height: 300,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          String ur='http://daitunglamhoasenorg.cf/assets/image/cmnd/'+widget.tv.hinh46;
          return Flexible(
              child: Image.network(
              ur,
          )
          );
        }
      },
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin cá nhân",
          style: TextStyle(fontSize: 22, color: Color(0xff333333)),
        ),
          automaticallyImplyLeading: false,
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
              //_image(),
              SizedBox(height: 20),
              _inforWidget(),
              SizedBox(height: 20),
//              RaisedButton(
//                onPressed:() {
//                  flag = !flag;
//                  sua = !sua;
//                  },
//                child: Text(flag==false?'Cập nhập':'lưu', style: TextStyle(fontSize: 20)),
//              ),
              //_btnLuu(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          flag = !flag;
          sua = !sua;
          print(flag==true?"cho sửa":"không cho sửa");
          //initState();
          //startUpload();
        },
        label: Text(flag==false?'Cập nhập':'lưu'),
        backgroundColor: Colors.pink,
      )
    );
  }

  Widget _entryField(String title,
      {bool isPassword = false, TextEditingController cont}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
          TextField (
            readOnly: !sua,
              controller: cont,
              obscureText: isPassword,
              style: TextStyle( fontSize: 20),
              decoration: InputDecoration(

                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),

        ],
      ),
    );
  }

  Widget _btnLuu(){
    return  RaisedButton(
      onPressed: _luu,
      child: const Text('Lưu', style: TextStyle(fontSize: 20)),
    );
  }
  Widget _inforWidget() {
    return Column(
      children: <Widget>[
        _entryField("Họ tên:", cont: hoten),
        _entryField("Pháp danh:", cont: phapdanh),
        _entryField("Ngày sinh:", cont: ngaysinh),
        _entryField("Giới tính:", cont: gioitinh),
        OutlineButton(onPressed: chooseImage, child: Text('Ảnh thẻ'),),
        _entryField("Nơi dk hộ khẩu:", cont: noidkhk),
        _entryField("Cmnd:", cont: cmnd),
        _entryField("Ngày cấp:", cont: ngaycap),
        _entryField("Nơi cấp:", cont: noicap),
        _entryField("Nghề nghiệp:", cont: nghenghiep),
        _entryField("Tình trạng thân nhân:", cont: tinhtrangthannhan),
        _entryField("Sđt cá nhân:", cont: sodtcanhan),
        _entryField("Sđt người thân:", cont: sodtnguoithan),
//        _entryField("Mặt trước cmnd:", cont: hinhcmnd1),
//        _entryField("Mặt sau cmnd:", cont: hinhcmnd2),
//        _entryField("Ghi chú:", cont: ghichu),
        _entryField("Tình trạng bệnh lý:", cont: tinhtrangbenhly),
      ],
    );
  }

  _luu()  async {
    String code = widget.tv.code;
    String _hoten = hoten.text;
    String _phapdanh = phapdanh.text;
    String _ngaysinh = ngaysinh.text;
    String _gioitinh = gioitinh.text;
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

    // cài đặt tham số PUT request
    String url = 'http://daitunglamhoasenorg.cf/api/app/update_thanhvien?code='+code;
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"hoten": "$_hoten", "phapdanh": "$_phapdanh", "ngaysinh": "$_ngaysinh", "gioitinh": "$_gioitinh", "noidkhk": "$_noidkhk","cmnd": "$_cmnd", "ngaycap": "$_ngaycap", "noicap": "$_noicap", "nghenghiep": "$_nghenghiep", "tinhtrangthannhan": "$_tinhtrangthannhan", "sodtcanhan": "$_sodtcanhan", "sodtnguoithan": "$_sodtnguoithan","tinhtrangbenhly": "$_tinhtrangbenhly","ghichu": "$_ghichu"}';
    print(url);
    print(json);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    print(statusCode);
  }
  void _timKiem() {

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TimKiem()));
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    String url = 'http://daitunglamhoasenorg.cf/api/app/update_thanhvien?code='+widget.tv.code;
    http.post(url, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }
}
