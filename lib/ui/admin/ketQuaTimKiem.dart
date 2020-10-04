import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:admin/model/khoaTu.dart';
import 'package:admin/ui/quetQRDangKy.dart';

class KetQua extends StatefulWidget {
  KetQua({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KetQuaState createState() => _KetQuaState();
}

class _KetQuaState extends State<KetQua> {
  //final kUrl = 'http://daitunglamhoasenorg.cf/api/khoatu';
  final kUrl = 'http://daitunglamhoasenorg.cf/api/khoatu';
  List<dynamic> data;
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
                        builder: (context)=>DangKyKhoaTu_Page(khoatu: khoatu,)
                    )
                );
              },
            );
          }
      ),
    );
  }
}
