import 'package:admin/model/user.dart';
import 'package:admin/ui/admin/custom_drawer/diem_danh_screen.dart';
import 'package:admin/ui/admin/custom_drawer/nhan_the_screen.dart';
import 'package:admin/ui/admin/custom_drawer/phong_screen.dart';
import 'package:admin/ui/admin/custom_drawer/search_screen.dart';
import 'package:admin/ui/admin/custom_drawer/tao_thanh_vien_screen.dart';
import 'package:admin/ui/admin/custom_drawer/thanh_vien_screen.dart';
import 'package:admin/ui/client/navigation_home_screen.dart';
import 'app_theme/app_theme.dart';
import 'custom_drawer/drawer_user_controller.dart';
import 'custom_drawer/ds_khoa_tu_screen.dart';
import 'custom_drawer/home_drawer.dart';
import 'package:flutter/material.dart';

class NavigationAdminScreen extends StatefulWidget {
  NavigationAdminScreen({this.user, this.url});
  User user;
  final String url;
  @override
  _NavigationAdminScreenState createState() => _NavigationAdminScreenState();
}

class _NavigationAdminScreenState extends State<NavigationAdminScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Rời khỏi giao diện quản trị viên?'),
            content: new Text(
                'Bạn có thực sự đăng xuất khỏi giao diện quản trị viên'),
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
    screenView = DSKhoaTuScreen(
      user: widget.user,
      url: widget.url,
    );
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
              },
              screenView: screenView,
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
          screenView = DSKhoaTuScreen(
            url: widget.url,
            user: widget.user,
          );
        });
      } else if (drawerIndex == DrawerIndex.timkiem) {
        setState(() {
          screenView = SearchScreen(
            url: widget.url,
            user: widget.user,
          );
        });
      } else if (drawerIndex == DrawerIndex.thongtintv) {
        setState(() {
          screenView = ThanhVienScreen(
            user: widget.user,
            url: widget.url,
          );
        });
      } else if (drawerIndex == DrawerIndex.diemdanh) {
        setState(() {
          screenView = DiemDanhScreen(
            user: widget.user,
            url: widget.url,
          );
        });
      }else if (drawerIndex == DrawerIndex.nhanthe) {
        setState(() {
          screenView = NhanTheScreen(
            user: widget.user,
            url: widget.url,
          );
        });
      }else if (drawerIndex == DrawerIndex.xepphong) {
        setState(() {
          screenView = PhongScreen(
            user: widget.user,
            url: widget.url,
          );
        });
      }else if (drawerIndex == DrawerIndex.taothanhvien) {
        setState(() {
          screenView = TaoThanhVienScreen(
            user: widget.user,
            url: widget.url,
          );
        });
      } else if (drawerIndex == DrawerIndex.dangxuat) {
        bool flag = false;
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Rời khỏi giao diện quản trị viên?'),
            content: new Text(
                'Bạn có thực sự đăng xuất khỏi giao diện quản trị viên'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () =>{
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
        //Navigator.pop(context);
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>NavigationHomeScreen(user: null,url: widget.url,)), (route) => false);
      } else {}
    }
  }
}
