import 'package:admin/model/thanhVien.dart';
import 'package:admin/model/user.dart';
import 'package:flutter/material.dart';
import '../app_theme/fintness_app_theme.dart';

class ThanhVienKhongHinhView extends StatefulWidget {
  final ThanhVien tv;
  final String url;
  final User user;
  const ThanhVienKhongHinhView({
    Key key,
    this.tv,
    this.url,
    this.user,
  }) : super(key: key);
  @override
  ThanhVienKhongHinhState createState() => ThanhVienKhongHinhState();
}

class ThanhVienKhongHinhState extends State<ThanhVienKhongHinhView> {
  @override
  Widget build(BuildContext context) {
    bool flag = false;
    return InkWell(
      onTap: () {
        setState(() {
          flag = !flag;
        });print(flag);
//        Navigator.of(context).push(
//            MaterialPageRoute(
//                builder: (context)=>ThongTinThanhVienScreen(url: url,user: user,tv: tv,)
//            )
//        );
      },
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
                      color: flag?Colors.red:Colors.white,
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    "Mã: ${widget.tv.code}",
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
                                    "Tên: ${widget.tv.hoten}",
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
