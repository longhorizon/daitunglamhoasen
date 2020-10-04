import 'dart:convert';
import 'package:admin/model/user.dart';
import '../../../model/khoaTu.dart';
import '../app_theme/app_theme.dart';
import 'khoa_tu_view.dart';
import '../app_theme/fintness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DSKhoaTuScreen extends StatefulWidget {
  DSKhoaTuScreen({this.user,this.url});
  User user;
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

  void addAllListData() {
    if (data == null) {
      String kUrl = widget.url+'/api/app/khoatu';
      http.get(kUrl).then((http.Response response) {
        setState(() {
          data = new List<Khoatu>();
          //print(response.body);
          json.decode(response.body).forEach((json) {
            Khoatu kt = Khoatu.fromJson(json);
            data.add(kt);
            listViews.add(KhoaTuView(khoatu: kt,url: widget.url,user: widget.user,));
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
                  'Danh sách khóa tu',
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
              top: 30 ,
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
