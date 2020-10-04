import 'dart:convert';
import '../../../model/thanhVien.dart';
import '../../../model/khoaTu.dart';
import '../app_theme.dart';
import 'khoa_tu_view.dart';
import 'fintness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DSKhoaTuScreen extends StatefulWidget {
  DSKhoaTuScreen({this.user,this.url});
  ThanhVien user;
  final String url;
  @override
  _DSKhoaTuState createState() => _DSKhoaTuState();
}

class _DSKhoaTuState extends State<DSKhoaTuScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  List<Khoatu> data;

  @override
  void initState() {
    addAllListData();
  }

  kiemtrangay(Khoatu khoatu) async{
    int _ngay = DateTime.now().day;
    int _thang = DateTime.now().month;
    int _nam = DateTime.now().year;
    DateTime now = new DateTime(_nam,_thang,_ngay);
    //now = DateTime.parse("$_nam-$_thang-$_ngay");
    print(now.isAfter(khoatu.ngayketthucdk));
    return now.isAfter(khoatu.ngayketthucdk);
//    if(now.isAfter(khoatu.ngayketthucdk))
//    {
//      print('false');
//      return false;
//    }
//    return true;
  }

  void addAllListData() {
    if (data == null) {
      String kUrl = widget.url+'/api/app/khoatu';print(kUrl);
      http.get(kUrl).then((http.Response response) {
        setState(() {
          data = new List<Khoatu>();
          print(response.body);
          json.decode(response.body).forEach((json) {
            Khoatu kt = Khoatu.fromJson(json);
            int _ngay = DateTime.now().day;
            int _thang = DateTime.now().month;
            int _nam = DateTime.now().year;
            DateTime now = new DateTime(_nam,_thang,_ngay);
            print(now.isAfter(kt.ngayketthucdk));
            if(!now.isAfter(kt.ngayketthucdk)) {
              print(kt.tieude);
              data.add(kt);
              listViews.add(
                  KhoaTuView(khoatu: kt, url: widget.url, user: widget.user,));
            }
          });
        });
      });
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          backgroundColor: FintnessAppTheme.background,
          flexibleSpace: appBar(),
        ),
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
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
              top: 10,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listViews[index];
            },
          );
        }
      },
    );
  }
}
