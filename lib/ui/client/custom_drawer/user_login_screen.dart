import 'dart:convert';

import 'package:admin/model/thanhVien.dart';
import 'package:admin/ui/client/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../navigation_home_screen.dart';

class UserLoginScreen extends StatefulWidget {
  @override
   UserLoginScreen({
  Key key,
  this.user,
    this.url,
  });
  ThanhVien user;
  final String url;
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLoginScreen> {
  @override
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  void initState() {
    super.initState();
  }
  Widget _entryField(String title, {bool isPassword = false,TextEditingController cont}) {
      return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: cont,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
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
            padding: const EdgeInsets.only(top: 10, left: 0, right: 8,),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 10),
                child: Text(
                  'Đại Tùng Lâm Hoa Sen',
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

  Widget _fieldWidget() {
    return Column(
      children: <Widget>[
        _entryField("Code",cont: _email),
        _entryField("Số điện thoại cá nhân",cont: _pass),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: ListView(
            children: <Widget>[
              appBar(),
//              Container(
//                padding: EdgeInsets.only(
//                    top: 5,//MediaQuery.of(context).padding.top,
//                    left: 16,
//                    right: 16),
//                child: Image.network('http://daitunglamhoasen.org//assets/image/gallery/h4.png'),
//              ),
              Container(
                padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 4),
                      _fieldWidget(),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _login();
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _login() async {
    String url = widget.url+'/api/app/loginUser';
    String email = _email.text;
    String pass = _pass.text;
    // cài đặt tham số Post request
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

          //Navigator ;
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => NavigationHomeScreen(user: widget.user,url: widget.url,)),(route) => false);
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Đăng nhập thành công!',),
                //content: Text("Đã đăng nhập ",color: const Color(0xFFFF00FF),),
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
}
