import 'package:admin/ui/admin/nhanThe.dart';
import 'package:admin/ui/admin/timkiem.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:admin/ui/chonKhoaTu.dart';
import 'package:admin/ui/dangNhap.dart';
import 'package:admin/model/user.dart';


class DSChucNang_page extends StatefulWidget {
  final User user;
  DSChucNang_page({
    this.user
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DSChucNang_page> {

  Widget _myPopup() {
    return PopupMenuButton<int>(
      itemBuilder: (context) =>
      [
        PopupMenuItem(
          value: 1,
          child: Text("Đăng nhập"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Nâng cao"),
        ),
      ],
      initialValue: 2,
      onSelected: (value) {
        print("value:$value");
        if(value == 1)
        {
          //_dangNhap();
        }
        else if(value == 2)
        {
          //_dangNhapAdmin();
        }
      },
      icon: Icon(Icons.list),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Đại Tùng Lâm Hoa Sen",
          style: TextStyle(fontSize: 22, color: Color(0xff333333)),),
        actions: <Widget>[
          _myPopup()
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.network('http://daitunglamhoasen.org/assets/image/gallery/h4.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                child: Text(
                  "Đại Tùng Lâm Hoa Sen",
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _denDSKhoaTu,
                    child: Text(
                      "Danh sách các khóa tu",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _timKiem,
                    child: Text(
                      "Tìm kiếm",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _quetNhanThe,
                    child: Text(
                      "Quét nhận thẻ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _denDSKhoaTu() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DSKhoaTu()));
  }

  void _timKiem() {
    print(widget.user.email);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TimKiem()));
  }

  void _quetNhanThe() {
    print(widget.user.email);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NhanThe_Page()));
  }
}
