import 'dart:convert';
import 'package:admin/model/khoaTu.dart';
import 'package:admin/model/user.dart';
import 'package:admin/ui/admin/custom_drawer/chon_phong_screen.dart';
import 'package:admin/ui/admin/custom_drawer/phong_view.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import '../app_theme/app_theme.dart';
import '../app_theme/fintness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhongScreen extends StatefulWidget {
  PhongScreen({this.user, this.url});
  User user;
  final String url;
  @override
  PhongState createState() => PhongState();
}

class PhongState extends State<PhongScreen> {
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
            int _ngay = DateTime.now().day;
            int _thang = DateTime.now().month;
            int _nam = DateTime.now().year;
            DateTime now = new DateTime(_nam,_thang,_ngay);
            if(now.isBefore(kt.ngayketthuctu)&&now.isAfter(kt.ngaybatdautu)) {
              data.add(kt);//print(kt.idctkhoatu);
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
                  'Xếp phòng',
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
            listViews.isNotEmpty?
            getMainListViewUI():
            Text("Hiện không có khóa tu nào đang diễn ra.",
            textAlign: TextAlign.center,
            style: TextStyle(
              //backgroundColor: Colors.blue,
                fontFamily: FintnessAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 24,
                letterSpacing: -0.1,
                color: Colors.red),
            ),
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

class KhoaTuView extends StatelessWidget {
  final Khoatu khoatu;
  final String url;
  final User user;

  const KhoaTuView({
    Key key,
    this.khoatu,
    this.url,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //print(khoatu.idctkhoatu);
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context)=>ChonPhongScreen(kt: khoatu,url: url,user: user,)
            )
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: FintnessAppTheme.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                bottomLeft: Radius.circular(18.0),
                bottomRight: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FintnessAppTheme.grey.withOpacity(0.2),
                  offset: Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.only(top: 16, left: 16, right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 4, bottom: 8, top: 16),
                      child: Text(
                        khoatu.tieude,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          //backgroundColor: Colors.blue,
                            fontFamily: FintnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            letterSpacing: -0.1,
                            color: Colors.red),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: FintnessAppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 0, bottom: 3),
                          child: Text(
                            'Ngày: ${formatDate(khoatu.ngaybatdautu, [dd, '-', mm, '-', yyyy])}',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 0, bottom: 3),
                          child: Text(
                            'Số lượng lên xe: ',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 0, bottom: 3),
                          child: Text(
                            'Đã xếp phòng: ',
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
    );
  }
}