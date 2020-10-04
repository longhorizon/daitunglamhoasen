import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:admin/model/khoaTu.dart';
import 'package:admin/ui/quetQRDangKy.dart';

import 'chiTietKhoaTu.dart';

class DSKhoaTu extends StatefulWidget {
  DSKhoaTu({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DSKhoaTuState createState() => _DSKhoaTuState();
}

class _DSKhoaTuState extends State<DSKhoaTu> {
  final kUrl = 'http://daitunglamhoasenorg.cf/api/khoatu';
  //final kUrl = 'http://172.17.5.244/daitunglam/api/khoatu';
  List<dynamic> data;


  //nút trở về
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Trở về',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _listDSKhoaTu() {
    return ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          if (data == null) return null;
          return new ListTile(
            title: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(data[index].idctkhoatu.toString(), style: new TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold),),
                new Text(data[index].tieude, style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
                //new Text(data[index].loaikhoatu, style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
//                  new Text(data[index].ngaybatdautu.toString(), style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
//                  new Text(data[index].ngayketthuctu.toString(), style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
                new Text('Ngày bắt đầy đăng ký: ' +data[index].ngaybatdaudk.toString(), style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
//                  new Text(data[index].ngayketthucdk.toString(), style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
              ],
            ),
            onTap: () {
//              Khoatu khoatu = data[index];
//              Navigator.of(context).push(
//                  MaterialPageRoute(
//                      builder: (context)=>DangKyKhoaTu_Page(khoatu: khoatu)
//                  )
//              );
            },
          );
        }
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
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
        'ádfghj',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }



  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _listDSKhoaTu()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      http.get(this.kUrl).then((http.Response response) {
        setState((){
          data = new List<Khoatu>();
          json.decode(response.body).forEach((json) {
            data.add(Khoatu.fromJson(json));
          });
        });
      });
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Danh sách khóa tu'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),

            onPressed: (){
            },
          )
        ],
      ),
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            if (data == null) return null;
            return new ListTile(
              title: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(data[index].idctkhoatu.toString(), style: new TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold),),
                  new Text(data[index].tieude, style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
                  //new Text(data[index].loaikhoatu, style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
//                  new Text(data[index].ngaybatdautu.toString(), style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
//                  new Text(data[index].ngayketthuctu.toString(), style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
                  new Text('Ngày bắt đầy đăng ký: ' +data[index].ngaybatdaudk.toString(), style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
//                  new Text(data[index].ngayketthucdk.toString(), style: new TextStyle(color: Colors.blueGrey, fontSize: 14.0),),
                ],
              ),
              onTap: () {
                Khoatu khoatu = data[index];
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=>ChiTietKhoaTu(khoatu: khoatu)
                    )
                );
              },
            );
          }
      ),
    );
  }
}
