import 'dart:convert';
import 'package:admin/model/thanhVien.dart';
import 'package:admin/model/user.dart';
import 'package:admin/ui/admin/custom_drawer/thong_tin_tv_screen.dart';
import 'package:flutter_beep/flutter_beep.dart';
import '../app_theme/app_theme.dart';
import '../app_theme/fintness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart';

class NhanTheScreen extends StatefulWidget {
  NhanTheScreen({this.user, this.url});
  User user;
  final String url;
  @override
  NhanTheState createState() => NhanTheState();
}

class NhanTheState extends State<NhanTheScreen> {
  ThanhVien tv = new ThanhVien();
  TextEditingController _inputCode = new TextEditingController();
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
                  'Quét mã nhận thẻ',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.white,
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
                    controller: _inputCode,
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: FintnessAppTheme.nearlyBlue,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhập mã code',
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
                  _postData(_inputCode.text);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.exit_to_app,
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

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 300,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        'assets/images/qrcodescan.png',
                      ),
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

    String code = barcode.substring(6, 11);
    print(code);
    this._inputCode.text = code;
    _postData(code);
  }

  _postData(String code) async {
    String url = widget.url + '/api/app/update_ngaynhanthe_thanhvien' + '?code=$code';
    Map<String, String> headers = {"Content-type": "application/json"};
    get(url).then((Response response) {
      int statusCode = response.statusCode;
      print(statusCode);

      print(url);
      print(statusCode);
      String body = response.body;
      if (statusCode == 200) {
        FlutterBeep.beep();
      } else {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thất bại!'),
              content: Text("Mã code vừa nhập không chính xác"),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: FintnessAppTheme.grey,
          flexibleSpace: appBar(),
        ),
        body: Column(
          children: <Widget>[
//            getSearchBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
            SizedBox(height: 20),
            _buttonGroup(),
          ],
        ),
      ),
    );
  }
}
