import 'dart:convert';
import 'package:admin/model/khoaTu.dart';
import 'package:admin/model/khuvuc.dart';
import 'package:admin/model/thanhVien.dart';
import 'package:admin/model/user.dart';
import 'package:admin/ui/admin/custom_drawer/danh_sach_tv_screen.dart';
import 'package:admin/ui/admin/custom_drawer/phong_view.dart';
import 'package:admin/ui/admin/custom_drawer/thanh_vien_tam_view.dart';
import 'package:admin/ui/admin/custom_drawer/thanh_vien_view.dart';
import 'package:flutter_beep/flutter_beep.dart';
import '../app_theme/app_theme.dart';
import '../app_theme/fintness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ChonPhongScreen extends StatefulWidget {
  ChonPhongScreen({this.user, this.url, this.kt});
  User user;
  final String url;
  final Khoatu kt;
  @override
  ChonPhongState createState() => ChonPhongState();
}

class ChonPhongState extends State<ChonPhongScreen> {
  List<Widget> listViews = <Widget>[];
  List<Widget> listViews1 = <Widget>[];
  final ScrollController scrollController = ScrollController();
  List<KhuVuc> data;
  List<ThanhVien> dsthanhvien;
  TextEditingController _inputCode = new TextEditingController();
  bool flag = false;
  List<ThanhVien> dschon = new List<ThanhVien>();
  KhuVuc khuvuc ;

  @override
  void initState() {
    addAllListDataThanhVien();
  }

  Future<void> addAllListData() async {
    if (data == null) {
      String kUrl = widget.url + '/api/app/khuvuc';
      print(kUrl);
      await get(kUrl).then((Response response) {
        print(response.body);
        setState(() {
          data = new List<KhuVuc>();
          json.decode(response.body).forEach((json) {
            KhuVuc kv = KhuVuc.fromJson(json);
            listViews.add(PhongView(
              kv: kv,
              kt: widget.kt,
              url: widget.url,
              user: widget.user,
            ));
          });
          print("số lượng phòng : ${listViews.length}");
        });
      });
    }
  }

  Future<void> addAllListDataThanhVien() async {
    if (data == null) {
      String kUrl = widget.url + '/api/app/khuvuc';
//      print(kUrl);
      await get(kUrl).then((Response response) {
//        print(response.body);
        setState(() {
          data = new List<KhuVuc>();
          json.decode(response.body).forEach((json) {
            KhuVuc kv = KhuVuc.fromJson(json); //print(kv.tenkhuvuc);
            if(khuvuc ==null){
              setState(() {
                khuvuc= kv;
              });
            }
            listViews.add(Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: flag
                            ? Colors.black.withOpacity(1)
                            : FintnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: InkWell(
                  child: PhongView(
                    kv: kv,
                    kt: widget.kt,
                    url: widget.url,
                    user: widget.user,
                  ),
                  onLongPress: () {
                    setState(() {
                      flag = !flag;
                      khuvuc = kv;
                    });
                    print(kv.id);

                  },
                )));
          });
        });
      });
    }
    for (int i = 0; i < listViews.length; i += 2) {
      listViews1.add(
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Expanded(
          child: listViews[i],
        ),
        (i + 1) == listViews.length
            ? Expanded(
                child: Text(""),
              )
            : Expanded(
                child: listViews[i + 1],
              ),
      ]));
    }
    listViews1.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Text(
                  'Danh Thành viên',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    String url = widget.url + '/api/app/dstvchuaxepphong';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json2 = '{"idctkhoatu": "${widget.kt.idctkhoatu}"}';
    Response response = await post(url, headers: headers, body: json2);
    int statusCode = response.statusCode;
    String body = response.body;
//      print(statusCode);
    if (statusCode == 200) {
      if (body.isNotEmpty && body != "[]") {
        setState(() {
          dsthanhvien = new List<ThanhVien>();
          json.decode(body).forEach((t) {
            ThanhVien tv = ThanhVien.fromJson1(t);
            dsthanhvien.add(tv);
            listViews1.add(_thanhvien(tv));
          });
        });
      } else {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thất bại!'),
              content: Text("Không tìm thấy thành viên phù hợp."),
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
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thất bại!'),
            content: Text("Đã xảy ra lỗi"),
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
                  'Danh sách phòng',
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

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: 5,
              bottom: 12 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews1.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return //listViews1[index];
                  GestureDetector(
                child: listViews1[index],
                onTap: () {
                  setState(() {
                    if(_postData(dsthanhvien[index- listViews1.length + dsthanhvien.length].code,khuvuc.id,index)){
//                      listViews1.removeAt(index);
//                      dsthanhvien.removeAt(index- listViews1.length + dsthanhvien.length);
                    }
                    //print(dschon.indexOf(dsthanhvien[index - listViews1.length + dsthanhvien.length]));
//                    if (dschon.indexOf(dsthanhvien[
//                            index - listViews1.length + dsthanhvien.length]) ==
//                        -1) {
//                      dschon.add(dsthanhvien[
//                          index - listViews1.length + dsthanhvien.length]);
//                      print(dsthanhvien[
//                              index - listViews1.length + dsthanhvien.length]
//                          .hoten);
//                    }
//                      listViews1.removeAt(index);
                  });
                },
              );
            },
          );
        }
      },
    );
  }
  _postData(String code,int idkhuvuc, int index) async {
    int idctkhoatu = widget.kt.idctkhoatu;print(idctkhoatu);
    String js = '{"code": "$code", "idctkhoatu": "$idctkhoatu","idkhuvuc": "$idkhuvuc"}';
    String url = widget.url+'/api/app/themtvvaophong';
    Map<String, String> headers = {"Content-type": "application/json"};
    print(url);
    print(js);
    Response response = await post(url, headers: headers, body: js);
    int statusCode = response.statusCode;
    String body = response.body;
    print(body);
    if(statusCode==201){
      FlutterBeep.beep();
      setState(() {
        listViews1.removeAt(index);
        dsthanhvien.removeAt(index- listViews1.length + dsthanhvien.length);
      });
      return true;

    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: FintnessAppTheme.grey,
          flexibleSpace: appBar(),
        ),
        body: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Container(
                    height: AppBar().preferredSize.height - 8,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        'Phòng đang chọn: ${khuvuc.tenkhuvuc}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            getMainListViewUI(),
//        ),
          ],
        ),
      ),
    );
  }

  Widget _thanhvien(ThanhVien tv) {
    bool flag = false;
    return InkWell(
//      onTap: () {
//        print(flag);
//        setState(() {
//          flag = !flag;
//        });
////        print(tv.hoten);print(flag);
//
////        Navigator.of(context).push(
////            MaterialPageRoute(
////                builder: (context)=>ThongTinThanhVienScreen(url: url,user: user,tv: tv,)
////            )
////        );
//      },
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: flag ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FintnessAppTheme.grey.withOpacity(0.4),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  key: null,
                                  onChanged: (bool value) {
                                    setState(() {
                                      flag = !flag;
                                    });
                                    print("aaa- $flag ");
                                  },
                                  value: flag,
                                  autofocus: true,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    "Mã: ${tv.code}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FintnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                      color: FintnessAppTheme.nearlyDarkBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    "Tên: ${tv.hoten}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FintnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                      color: FintnessAppTheme.nearlyDarkBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
