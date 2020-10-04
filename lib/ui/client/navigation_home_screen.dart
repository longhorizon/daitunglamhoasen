import 'package:admin/model/thanhVien.dart';
import 'package:admin/ui/client/custom_drawer/qr_screen.dart';
import 'package:admin/ui/client/custom_drawer/thanh_vien_screen.dart';
import 'package:admin/ui/client/custom_drawer/xem_phong_screen.dart';
import 'custom_drawer/khoa_tu_screen.dart';
import 'custom_drawer/test.dart';
import 'custom_drawer/user_login_screen.dart';
import 'app_theme.dart';
import 'custom_drawer/drawer_user_controller.dart';
import 'custom_drawer/home_drawer.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  NavigationHomeScreen({this.user, this.url});
  ThanhVien user;
  final String url;
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Thoát ứng dụng?'),
            content: new Text('Bạn có thực sự muốn thoát ứng dụng'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Không'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Có'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        color: AppTheme.nearlyWhite,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body: DrawerUserController(
              user: widget.user,
              url: widget.url,
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
                //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
              },
              screenView: screenView,
              //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.KhoaTu) {
        setState(() {
          screenView = DSKhoaTuScreen(
            user: widget.user,
            url: widget.url,
          );
        });
      } else if (drawerIndex == DrawerIndex.ThongTin) {
        setState(() {
          screenView = ThanhVienScreen(
            tv: widget.user,
            url: widget.url,
          );
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          screenView = UploadImageDemo();
        });
      }else if (drawerIndex == DrawerIndex.qr) {
        setState(() {
          screenView = QRScreen(
            user: widget.user,
            url: widget.url,
          );
        });
      }else if (drawerIndex == DrawerIndex.xemphong) {
        setState(() {
          screenView = XemPhongScreen(
            user: widget.user,
            url: widget.url,
          );
        });
      } else if (drawerIndex == DrawerIndex.Login) {
        setState(() {
          screenView = UserLoginScreen(
            url: widget.url,
          );
        });
      } else if (drawerIndex == DrawerIndex.Logout) {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Xác nhận đăng xuất'),
            content: new Text('Bạn có thực sự muốn đăng xuất?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => {
                  drawerIndex = DrawerIndex.HOME,
                  Navigator.pop(context),
                },
                child: new Text('Không'),
              ),
              new FlatButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationHomeScreen(
                              user: null,
                              url: widget.url,
                            )),
                    (route) => false),
                child: new Text('Có'),
              ),
            ],
          ),
        );
      } else {}
    }
  }
}
