import 'package:admin/model/thanhVien.dart';
import 'package:admin/model/user.dart';
import 'package:admin/ui/admin/custom_drawer/thanh_vien_screen.dart';
import 'package:admin/ui/admin/custom_drawer/thong_tin_tv_screen.dart';
import 'package:flutter/material.dart';
import '../app_theme/fintness_app_theme.dart';

class ThanhVienView extends StatelessWidget {
  final ThanhVien tv;
  final String url;
  final User user;
  const ThanhVienView({
    Key key,
    this.tv,
    this.url,
    this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context)=>ThongTinThanhVienScreen(url: url,user: user,tv: tv,)
            )
        );
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
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FintnessAppTheme.white,
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
                                    left: 130,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    "Mã: "+tv.code,
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
                                    left: 130,
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
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 130,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    "Pháp danh: ${tv.phapdanh}",
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
                                    left: 130,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    "Sđt: ${tv.sodtcanhan}",
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
                Positioned(
                  top: -50,
                  left: 0,
                  child: SizedBox(
                    width: 120,
                    height: 200,
                    child: this.tv.hinh46!=""?Image.network(url+'/assets/image/cmnd/'+tv.hinh46):Image.asset('assets/images/user.png'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
