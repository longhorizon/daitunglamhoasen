import 'dart:convert';
import 'dart:typed_data';
import 'package:date_format/date_format.dart';
import '../../../model/khoaTu.dart';
import '../../../model/thanhVien.dart';
import '../app_theme.dart';
import '../navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'fintness_app_theme.dart';

class ChiTietKhoaTuScreen extends StatefulWidget {
  final Khoatu khoatu;
  final String url;
  ThanhVien user;

  ChiTietKhoaTuScreen({
    this.khoatu,
    this.url,
    this.user,
  });
  ChiTietKhoaTuState createState() => ChiTietKhoaTuState();
}

class ChiTietKhoaTuState extends State<ChiTietKhoaTuScreen> {
  Uint8List bytes = Uint8List(0);
  int flag = 0;

  void initState() {
    kiemtrangay();
    super.initState();
  }

  Widget _tomtat() {
    return new Text('Tóm tắt: ${widget.khoatu.tomtat==null?'(cập nhập)':widget.khoatu.tomtat}',
      style: new TextStyle(
          fontSize: 20,
          fontFamily: "Roboto"),
    );
  }

  Widget _loaikhoatu() {
    return new Text('Loại khóa tu: ${widget.khoatu.loaikhoatu==null?'(cập nhập)':widget.khoatu.loaikhoatu}',
      style: new TextStyle(
          fontSize: 20,
//          color: const Color(0xFF000000),
//          fontWeight: FontWeight.w200,
          fontFamily: "Roboto"),
    );
  }

  Widget _ngaybatdautu() {
    return new Text( 'Ngày bắt đầu: '+
      formatDate(widget.khoatu.ngaybatdautu, [dd, '-', mm, '-', yyyy]).toString(),
      style: new TextStyle(
          fontSize: 20,
//          color: const Color(0xFF000000),
          fontFamily: "Roboto"),
    );
  }

  Widget _ngayketthuctu() {
    return new Text("Ngày kêt thúc: "+
      formatDate(widget.khoatu.ngayketthuctu, [dd, '-', mm, '-', yyyy]).toString(),
      style: new TextStyle(
          fontSize: 20,
//          color: const Color(0xFF000000),
          fontFamily: "Roboto"),
    );
  }

  Widget _ngaybatdaudk() {
    return new Text("Này bắt đầu: "+
      formatDate(widget.khoatu.ngaybatdaudk, [dd, '-', mm, '-', yyyy]).toString(),
      style: new TextStyle(
          fontSize: 20,
//          color: const Color(0xFF000000),
          fontFamily: "Roboto"),
    );
  }

  Widget _ngayketthucdk() {
    return new Text("Ngày kết thúc: "+
      formatDate(widget.khoatu.ngayketthucdk, [dd, '-', mm, '-', yyyy]).toString(),
      style: new TextStyle(
          fontSize: 20,
//          color: const Color(0xFF000000),
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
                    SizedBox(height: 50),
                    _loaikhoatu(),
                    SizedBox(height: 20),
                    _tomtat(),
                    SizedBox(height: 40),
                    Text(
                      'Thời gian diễn ra: ',
                      style: new TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontFamily: "Roboto"),
                    ),
                    SizedBox(height: 20),
                    _ngaybatdautu(),
                    SizedBox(height: 20),
                    _ngayketthuctu(),
                    SizedBox(height: 40),
                    Text(
                      'Thời gian đăng ký: ',
                      style: new TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontFamily: "Roboto"),
                    ),
                    SizedBox(height: 20),
                    _ngaybatdaudk(),
                    SizedBox(height: 20),
                    _ngayketthucdk(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (flag == 0) {
            kiemtra();
          }
        },
        label: Text(
          flag ==0 ? 'Đăng Ký' :flag == 1? 'Hết hạn đăng ký':'Chưa thể đăng ký',
        ),
        backgroundColor: Colors.pink,
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
                  widget.khoatu.tieude,
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

  kiemtrangay() async{
    int _ngay = DateTime.now().day;
    int _thang = DateTime.now().month;
    int _nam = DateTime.now().year;
    DateTime now = new DateTime(_nam,_thang,_ngay);
    //now = DateTime.parse("$_nam-$_thang-$_ngay");
    print(now.toString());
    if(now.isAfter(widget.khoatu.ngayketthucdk))
      {
        flag = 1;
      }
    else if(now.isBefore(widget.khoatu.ngaybatdaudk))
      {
        flag = 2;
      }
  }

  kiemtra() async {
    if (widget.user == null && flag == 0) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _code = TextEditingController();
          TextEditingController _sdt = TextEditingController();
          return AlertDialog(
            title: const Text('Bạn cần phải đăng nhập!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("code"),
                TextField(
                    controller: _code,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true)
                ),
                Text("Số điện thoại cá nhân"),
                TextField(
                    controller: _sdt,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true)
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Thoát'),
              ),
              FlatButton(
                onPressed: () {
                  _login(_code.text, _sdt.text);
                },
                child: const Text('Đăng nhập'),
              ),
            ],
          );
        },
      );
    } else if (widget.user != null && flag == 0) {
      dangky();
    }
  }

  _login(String code, String sdt) async {
    String url = widget.url+'/api/app/loginUser';
    String email = code;
    String pass = sdt;
    Map<String, String> headers = {"Content-type": "application/json"};
    String js = '{"code": "$email","sodtcanhan": "$pass"}';
    print(url);
    print(js);
    Response response = await post(url, headers: headers, body: js);
    int statusCode = response.statusCode;
    String body = response.body;
    print(statusCode);
    print(body);
    if (statusCode == 200) {

      get(url).then((Response response) {
        setState(() {
         widget.user = ThanhVien.fromJson(json.decode(body));
         dangky();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationHomeScreen(user: widget.user,url: widget.url,)),(route) => false
          );
//          showDialog<void>(
//            context: context,
//            builder: (BuildContext context) {
//              String temp = widget.khoatu.tieude;
//              return AlertDialog(
//                title: const Text('Đăng ký thành công1!',),
//                content: Text("Bạn đã đăng ký thành công khóa tu $temp.",),
//                actions: <Widget>[
//                  FlatButton(
//                    onPressed: () {
//                      Navigator.pop(context);
//                    },
//                    child: const Text('OK'),
//                  ),
//                ],
//              );
//            },
//          );
        });
      });
    } else {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thất bại!'),
            content: Text("code hoặc số điện thoại của bạn không chính xác"),
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

  dangky() async {
    // cài đặt tham số PUT request
    String url = widget.url + '/api/app/insertdangky';
    Map<String, String> headers = {"Content-type": "application/json"};
    String code = widget.user.code;
    String idctkhoatu = widget.khoatu.idctkhoatu.toString();
    String json = '{"code": "$code", "idctkhoatu": "$idctkhoatu"}';
    print(url);
    print(json);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    print(statusCode);
    if (statusCode == 200) {
      print('đăng ký');
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          String temp = widget.khoatu.tieude;
          return AlertDialog(
            title: const Text('Đăng ký thành công!'),
            content: Text("Bạn đã đăng ký thành công khóa tu $temp.",),
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
