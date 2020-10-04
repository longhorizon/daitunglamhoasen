import 'dart:typed_data';
import 'package:admin/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:admin/model/khoaTu.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class DangKyKhoaTuScreen extends StatefulWidget {
   Khoatu khoatu;
   User user;
  String url;
  DangKyKhoaTuScreen({this.khoatu, this.user, this.url});
   @override
   DangKyState createState() => DangKyState();
}

class DangKyState extends State<DangKyKhoaTuScreen>{

  Uint8List bytes = Uint8List(0);
  TextEditingController _inputCode = TextEditingController();

  get context => null;

  @override

  Widget _submitButton() {
    return InkWell(
        onTap: () {
          _postData(_inputCode.text);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            'Đăng ký',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: new AppBar(
          title: new Text(widget.khoatu.tieude),
          automaticallyImplyLeading: true,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextField(
                        controller: _inputCode,
                        //readOnly: true,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Nhập mã code',
                          hintStyle: TextStyle(fontSize: 15),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                        ),
                      ),
                      SizedBox(height: 20),
                      this._buttonGroup(),
                      SizedBox(height: 70),
                      this._submitButton(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSh1kP_d6RUc_cxsq58sj3C-d4LCYG-QQjtzQ&usqp=CAU'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan")),
                    //RaisedButton( child: Text("Beep Success"), onPressed: ()=> FlutterBeep.beep()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    String code = barcode.substring(7,12);
    this._inputCode.text = code;
    //_postData(code);
  }

  _postData(String barcode) async {
    int idctkhoatu = widget.khoatu.idctkhoatu;
    String code = barcode;
    String json = '{"idctkhoatu": "$idctkhoatu", "code": "$code"}';
    String url = widget.url+'/api/app/insertdangky';
    Map<String, String> headers = {"Content-type": "application/json"};
    print(url);
    print(json);
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    print(statusCode);

    String body = response.body;
    if(statusCode==201){
      FlutterBeep.beep();
    }else if(statusCode==422){
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo!'),
            content: Text("Thành viên đã đăng ký khóa tu này."),
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
    }else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo!'),
            content: Text("Đã sảy ra lỗi"),
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
