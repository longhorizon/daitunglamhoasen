import 'dart:convert';
import 'package:admin/model/thanhVien.dart';
import 'package:admin/model/user.dart';
import 'package:admin/ui/admin/custom_drawer/search_results_screen.dart';
import '../app_theme/app_theme.dart';
import '../app_theme/fintness_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import 'thanh_vien_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({this.user, this.url});
  User user;
  final String url;
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<SearchScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  TextEditingController key = TextEditingController();
  List<ThanhVien> data = new List<ThanhVien>();
  static List<PopularFilterListData> phuongthuctimkiem = [
    PopularFilterListData(
      titleTxt: 'Tất cả',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Tên',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Pháp danh',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Số điện thoại',
      isSelected: true,
    ),
  ];

  @override
  void initState() {
    //addAllListData();
  }

  Future<void> addAllListData() async {
    data.clear();
    listViews.clear();
    if (data.length == 0) {
      String url = widget.url + '/api/app/search';
      String k = key.text; //print(k);
      Map<String, String> headers = {"Content-type": "application/json"};
      String json1 = '{"key": "$k"}';print(json1);
      http.Response response = await http.post(url, headers: headers, body: json1);
      int statusCode = response.statusCode;
      String body = response.body;print(body);
        if(statusCode == 200 && body.isNotEmpty && body!="[]") {
          json.decode(body).forEach((t) {
            ThanhVien tv = ThanhVien.fromJson(t);
            data.add(tv);
            listViews.add(
                ThanhVienView(user: widget.user, url: widget.url, tv: tv,));

          });
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context)=>SearchResultsScreen(url: widget.url,user: widget.user,listviews: listViews,)
              )
          );
        }else {
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
                  'Tìm kiếm thành viên',
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
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    getSearchBarUI(),
                    const Divider(
                      height: 1,
                    ),
                    //popularFilter(),
                    const Divider(
                      height: 1,
                    ),
                    allAccommodationUI()
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: FintnessAppTheme.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      addAllListData();
                    },
                    child: Center(
                      child: Text(
                        'Tìm kiếm',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: FintnessAppTheme.background,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: key,
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: FintnessAppTheme.nearlyBlue,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nguyễn Văn...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: FintnessAppTheme.grey,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  addAllListData();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: FintnessAppTheme.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Tìm kiếm theo',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccomodationListUI(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < phuongthuctimkiem.length; i++) {
      final PopularFilterListData date = phuongthuctimkiem[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      date.titleTxt,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: date.isSelected
                        ? FintnessAppTheme.grey
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    value: date.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(
          height: 1,
        ));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (phuongthuctimkiem[0].isSelected) {
        phuongthuctimkiem.forEach((d) {
          d.isSelected = false;
        });
      } else {
        phuongthuctimkiem.forEach((d) {
          d.isSelected = true;
        });
      }
    } else {
      phuongthuctimkiem[index].isSelected =
          !phuongthuctimkiem[index].isSelected;

      int count = 0;
      for (int i = 0; i < phuongthuctimkiem.length; i++) {
        if (i != 0) {
          final PopularFilterListData data = phuongthuctimkiem[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == phuongthuctimkiem.length - 1) {
        phuongthuctimkiem[0].isSelected = true;
      } else {
        phuongthuctimkiem[0].isSelected = false;
      }
    }
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
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
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

class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;
}
