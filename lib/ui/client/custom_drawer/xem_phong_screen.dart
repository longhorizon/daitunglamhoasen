import 'dart:convert';
import 'dart:typed_data';
import 'package:admin/model/khuvuc.dart';
import 'package:date_format/date_format.dart';
import '../../../model/khoaTu.dart';
import '../../../model/thanhVien.dart';
import '../app_theme.dart';
import '../navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'fintness_app_theme.dart';

class XemPhongScreen extends StatefulWidget {
  final String url;
  ThanhVien user;

  XemPhongScreen({
    this.url,
    this.user,
  });
  XemPhongState createState() => XemPhongState();
}

class XemPhongState extends State<XemPhongScreen> {
  Uint8List bytes = Uint8List(0);
  int flag = 0;
  KhuVuc kv = new KhuVuc();
  TextEditingController _key = new TextEditingController();

  void initState() {
//    kiemtrangay();
    laydulieuphong(widget.user.code);
    super.initState();
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: FintnessAppTheme.background,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: _key,
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: FintnessAppTheme.nearlyBlue,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhập chính xác code',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: FintnessAppTheme.grey,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  laydulieuphong(_key.text);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: FintnessAppTheme.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tenkv() {
    return new Text('Tên phòng: ${kv.tenkhuvuc==null?'(cập nhập)':kv.tenkhuvuc}',
      style: new TextStyle(
          fontSize: 20,
          fontFamily: "Roboto"),
    );
  }

  Widget _doituong() {
    return new Text('Đối tượng: ${kv.doituong==null?'(cập nhập)':kv.doituong}',
      style: new TextStyle(
          fontSize: 20,
//          color: const Color(0xFF000000),
//          fontWeight: FontWeight.w200,
          fontFamily: "Roboto"),
    );
  }

  Widget _mota() {
    return new Text('Mô tả: ${kv.mota==null?'(cập nhập)':kv.mota}',
      style: new TextStyle(
          fontSize: 20,
//          color: const Color(0xFF000000),
//          fontWeight: FontWeight.w200,
          fontFamily: "Roboto"),
    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: new AppBar(

        backgroundColor: Colors.pink,//FintnessAppTheme.background,
        flexibleSpace: appBar(),
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
//              Positioned(
//                  top: -height * .15,
//                  right: -MediaQuery.of(context).size.width * .4,
//                  child: BezierContainer()),
            Container(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 8, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    getSearchBarUI(),
                    SizedBox(height: 20),
                    _tenkv(),
                    SizedBox(height: 20),
                    _doituong(),
                    SizedBox(height: 20),
                    _mota(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Text(
                  "Thông tin chỗ ở",
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//  kiemtrangay() async{
//    int _ngay = DateTime.now().day;
//    int _thang = DateTime.now().month;
//    int _nam = DateTime.now().year;
//    DateTime now = new DateTime(_nam,_thang,_ngay);
//    //now = DateTime.parse("$_nam-$_thang-$_ngay");
//    print(now.toString());
//    if(now.isAfter(widget.khoatu.ngayketthucdk))
//    {
//      flag = 1;
//    }
//    else if(now.isBefore(widget.khoatu.ngaybatdaudk))
//    {
//      flag = 2;
//    }
//  }

//  kiemtra() async {
//    if (widget.user == null && flag == 0) {
//      await showDialog<void>(
//        context: context,
//        builder: (BuildContext context) {
//          TextEditingController _code = TextEditingController();
//          TextEditingController _sdt = TextEditingController();
//          return AlertDialog(
//            title: const Text('Bạn cần phải đăng nhập!'),
//            content: Column(
//              mainAxisSize: MainAxisSize.min,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text("code"),
//                TextField(
//                    controller: _code,
//                    decoration: InputDecoration(
//                        border: InputBorder.none,
//                        fillColor: Color(0xfff3f3f4),
//                        filled: true)
//                ),
//                Text("Số điện thoại cá nhân"),
//                TextField(
//                    controller: _sdt,
//                    decoration: InputDecoration(
//                        border: InputBorder.none,
//                        fillColor: Color(0xfff3f3f4),
//                        filled: true)
//                ),
//              ],
//            ),
//            actions: <Widget>[
//              FlatButton(
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//                child: const Text('Thoát'),
//              ),
//              FlatButton(
//                onPressed: () {
//                  _login(_code.text, _sdt.text);
//                },
//                child: const Text('Đăng nhập'),
//              ),
//            ],
//          );
//        },
//      );
//    } else if (widget.user != null && flag == 0) {
//      dangky();
//    }
//  }


  laydulieuphong(String code) async {
    String url = widget.url + '/api/app/layphong';
    Map<String, String> headers = {"Content-type": "application/json"};
    String js = '{"code": "$code"}';
    print(url);
    print(js);
    Response response = await post(url, headers: headers, body: js);
    int statusCode = response.statusCode;
    print(statusCode);
    print(response.body);
    if (statusCode == 200) {
      setState(() {
        kv = KhuVuc.fromJson(json.decode(response.body) );
      });
    }else if (statusCode == 422)
      {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: Text("Bạn chưa điểm danh hoặc chưa được xếp phòng",),
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
    else if (statusCode == 500)
    {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: Text("Code vừa nhập không chính xác hoặc đã có lỗi xảy ra",),
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
}
