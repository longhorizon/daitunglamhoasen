import 'dart:convert';
import 'package:admin/model/user.dart';
import 'package:admin/ui/admin/navigation_admin_screen.dart';
import 'package:admin/ui/client/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WarningScreen extends StatefulWidget {
  WarningScreen({
    this.url,
  });
  final String url;
  @override
  _WarningState createState() => _WarningState();
}

class _WarningState extends State<WarningScreen> {
  @override
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  User user = new User();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 30, //MediaQuery.of(context).padding.top,
                        left: 16,
                        right: 16),
                    child: Image.asset(
                      'assets/images/warning.png',
                      width: 130,
                      height: 130,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 15),
                    child: Text(
                      'Phần này chỉ dành cho quản trị viên!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildComposer('Gmail', isPassword: false, cont: _email),
                  _buildComposer('Password', isPassword: true, cont: _pass),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Container(
                        width: 120,
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
                              FocusScope.of(context).requestFocus(FocusNode());
                              _login();
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer(String text,
      {bool isPassword = false, TextEditingController cont}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                controller: cont,
                obscureText: isPassword,
                maxLines: 1,
                onChanged: (String txt) {},
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: text),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    String url = widget.url+'/api/app/login';
    String email = _email.text;
    String pass = _pass.text;
    // cài đặt tham số PUT request
    Map<String, String> headers = {"Content-type": "application/json"};
    String json1 = '{"username": "$email","password": "$pass"}';
//    print(url);
//    print(widget.url);
//    print(json1);
    Response response = await post(url, headers: headers, body: json1);
    int statusCode = response.statusCode;
    String body = response.body;
//    print(statusCode);
    print(body);
    if (statusCode == 200) {
      http.get(url).then((http.Response response) {
        setState(() {
          user = User.fromJson(json.decode(body));
          print(user.uid);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationAdminScreen(
                        user: user,
                        url: widget.url,
                      )));
        });
      });
      //print(body);

    } else {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thất bại!'),
            content: Text("Email hoặc pass không chính xác"),
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
