import 'dart:convert';
import 'package:admin/model/khoaTu.dart';
import 'package:admin/model/khuvuc.dart';
import 'package:admin/model/thanhVien.dart';
import 'package:admin/model/user.dart';
import 'package:admin/ui/admin/custom_drawer/danh_sach_tv_screen.dart';
import 'package:admin/ui/admin/custom_drawer/thanh_vien_tam_view.dart';
import 'package:http/http.dart';
import '../app_theme/fintness_app_theme.dart';
import 'package:flutter/material.dart';

class PhongView extends StatefulWidget {
  final String url;
  final User user;
  final KhuVuc kv;
  final Khoatu kt;

  const PhongView({
    Key key,
    this.kv,
    this.url,
    this.user,
    this.kt,
  }) : super(key: key);

  @override
  PhongState createState() => PhongState();
}

class PhongState extends State<PhongView> {
  int soluong = 0;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  List<ThanhVien> data = new List<ThanhVien>();
  bool flag = false;

  @override
  void initState() {
    laysoluong();
  }

  Future<void> layds() async {

    if (data != null) {
          data.clear();
    listViews.clear();
    }
      String url = widget.url + '/api/app/dstvphong';
//      print(url);
      Map<String, String> headers = {"Content-type": "application/json"};
      String json1 = '{"idkhuvuc": "${widget.kv.id}", "idctkhoatu": "${widget.kt.idctkhoatu}"}';
//      print(json1);
      Response response = await post(url, headers: headers, body: json1);
      int statusCode = response.statusCode;
      String body = response.body;
        if (body.isNotEmpty && body != "[]" && statusCode == 200) {
//          print(body);
          json.decode(body).forEach((t) {
            ThanhVien tv = ThanhVien.fromJson1(t);//print(tv.hoten);
            data.add(tv);
            listViews.add(ThanhVienKhongHinhView(
              user: widget.user,
              url: widget.url,
              tv: tv,
            ));
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TVPhongScreen(
                url: widget.url,
                user: widget.user,
                kv: widget.kv,
                listviews: listViews,
              )));
        } else {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Thông báo'),
                content: Text("Phòng trống."),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onDoubleTap: (){
          layds();
          },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 2, right: 10, top: 10, bottom: 2),
          child: Container(
            decoration: BoxDecoration(
              color: soluong / widget.kv.succhua * 10 > 5
                  ? soluong / widget.kv.succhua * 10 > 8
                      ? Colors.red
                      : Colors.orange
                  : Colors.greenAccent, //FintnessAppTheme.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: //Colors.black.withOpacity(1),
                      FintnessAppTheme.grey.withOpacity(0.2),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 16, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 4, bottom: 8, top: 6),
                        child: Text(
                          widget.kv.tenkhuvuc,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              //backgroundColor: Colors.blue,
                              fontFamily: FintnessAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              letterSpacing: -0.1,
                              color: Colors.black),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 0, bottom: 3),
                            child: Text(
                              '${widget.kv.doituong} - ${soluong}/${widget.kv.succhua}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FintnessAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: FintnessAppTheme.nearlyDarkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void laysoluong() async {
    String kUrl = widget.url +
        '/api/app/demtongnguoithamgia?idctkhoatu=${widget.kt.idctkhoatu}&idkhuvuc=${widget.kv.id}';
//    print(kUrl);
    Response response = await get(kUrl);
//    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        this.soluong = json.decode(response.body) as int;
      });
//      print(soluong);
    }
  }
}
