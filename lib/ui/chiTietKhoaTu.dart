import 'dart:typed_data';

import 'package:admin/model/khoaTu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class ChiTietKhoaTu extends StatelessWidget {
  final Khoatu khoatu ;

  ChiTietKhoaTu({this.khoatu});
  Uint8List bytes = Uint8List(0);
  Widget _tieuDe(){
    return
        new Text(
          khoatu.tieude,
          style: new TextStyle(fontSize:12.0,
              color: Colors.black,
              fontFamily: "Roboto"),

    );
  }

  Widget _tomtat(){
    return
        new Text(
        khoatu.tomtat,
          style: new TextStyle(fontSize:12.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"),

    );
  }

  Widget _noidung(){
    return
        new Text(
          khoatu.tomtat,
          style: new TextStyle(fontSize:12.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"),

    );
  }

  Widget _loaikhoatu(){
    return
        new Text(
          "",
          //khoatu.loaikhoatu,
          style: new TextStyle(fontSize:12.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"),

    );
  }

  Widget _ngaybatdautu(){
    return
        new Text(
          khoatu.ngaybatdautu.day.toString(),
          style: new TextStyle(fontSize:12.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"),

    );
  }

  Widget _ngayketthuctu(){
    return
        new Text(
          "",
          style: new TextStyle(fontSize:12.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"),

    );
  }

  Widget _ngaybatdaudk(){
    return
        new Text(
          "",
          style: new TextStyle(fontSize:12.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"),

    );
  }

  Widget _ngayketthucdk(){
    return
        new Text(
          "",
          style: new TextStyle(fontSize:12.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"),

    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: new AppBar(
          title: new Text('chi tiêt khóa tu'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),

              onPressed: (){
              },
            )
          ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 50),
                      _tieuDe(),
                      SizedBox(height: 20),
                      _loaikhoatu(),
                      SizedBox(height: 20),
                      _ngaybatdautu(),
                      SizedBox(height: 20),
                      _ngayketthuctu(),
                      SizedBox(height: 20),
                      _ngaybatdaudk(),
                      SizedBox(height: 20),
                      _ngayketthucdk(),
                      SizedBox(height: 20),
                      _noidung(),
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
          // code đăng ký
        },
        label: Text('Đăng Ký'),
        backgroundColor: Colors.pink,
      ),
    );
  }
}