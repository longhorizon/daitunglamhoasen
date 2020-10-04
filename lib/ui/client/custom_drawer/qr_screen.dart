import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:admin/model/thanhVien.dart';
import 'package:admin/ui/client/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRScreen extends StatefulWidget {
  @override
  QRScreen({
    Key key,
    this.user,
    this.url,
  });
  ThanhVien user;
  final String url;
  _QRState createState() => _QRState();
}

class _QRState extends State<QRScreen> {
  Uint8List bytes = Uint8List(0);

  @override
  initState() {
    _taoQR();
  }

  Widget appBar() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 0,
              right: 8,
            ),
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
                  'Code QR',
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
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            children: <Widget>[
              appBar(),
              Container(
                padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 60, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 250,
                              child: bytes.isEmpty
                                  ? Center(
                                      child: Text('Empty code ... ',
                                          style:
                                              TextStyle(color: Colors.black38)),
                                    )
                                  : Image.memory(bytes),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future _taoQR() async {
    String code = 'HS';
    widget.user.gioitinh=="Nam"?code+='T':code+='D';
    code += widget.user.ngaysinh.substring(widget.user.ngaysinh.length-4,widget.user.ngaysinh.length-3);
    code += widget.user.ngaysinh.substring(widget.user.ngaysinh.length-2,widget.user.ngaysinh.length);
    code += widget.user.code;
    print(code);
    Uint8List result = await scanner.generateBarCode(code);
    this.setState(() => this.bytes = result);
  }
}
