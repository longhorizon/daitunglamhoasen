import 'dart:convert';
import 'dart:typed_data';

import 'package:admin/model/thanhVien.dart';
import 'package:admin/ui/admin/updateThanhVien.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:qrscan/qrscan.dart' as scanner;

class TimKiem extends StatefulWidget {
  TimKiem({Key key, this.title}) : super(key: key);

  final String title;

  @override
  TimKiem_Page createState() => TimKiem_Page();
}

class TimKiem_Page extends State<TimKiem> {
  TimKiem_Page();
  Uint8List bytes = Uint8List(0);
  TextEditingController _inputCode = TextEditingController();

  final kUrl = 'http://daitunglamhoasenorg.cf/api/app/timkiem';
  List<dynamic> data;

  @override
  Widget _submitButton() {
    return InkWell(
        onTap: () {
          _timKiem();
          //_makePutRequest();
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
            'Tìm',
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
          title: new Text('Tìm Kiếm'),
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
    String code = barcode.substring(6,barcode.length);
    this._inputCode.text = code;
    _timKiem();
  }

  _timKiem() async {
    String code = _inputCode.text;
    String url = this.kUrl + '?code=$code';
    print(url);
    http.get(url).then((http.Response response) {
      int statusCode = response.statusCode;
      print(statusCode);

      if (statusCode == 200) {
        ThanhVien tv = new ThanhVien();
        tv = ThanhVien.fromJson(json.decode(response.body));
        print(json.decode(response.body));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => updateThanhVien(tv: tv)));
        // });
        //         });

      } else {
        setState(() async {
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Không tìm thấy!'),
                content: Text("Mã code không tồn tại"),
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
        });
      }
    });
  }
}
