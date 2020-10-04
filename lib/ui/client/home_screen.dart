import 'package:admin/ui/client/app_theme.dart';
import 'package:flutter/material.dart';

import 'custom_drawer/fintness_app_theme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {


  Widget _padding(){
    return Padding(
      padding: EdgeInsets.only(
        top: 60,
        bottom: 5,
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
          automaticallyImplyLeading: false,
          backgroundColor: FintnessAppTheme.background,
          flexibleSpace: appBar(),
        ),
        body: ListView(
          children: <Widget>[
            _padding(),
            Text(
                '"Cuộc sống của chúng ta \n được định hình bởi chính tâm trí của chúng ta.Chúng ta sẽ trở thành những gì chúng ta nghĩ."',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.red,
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto"
              ),
            ),
            Text(
              'Lời Phật Dạy',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 22,
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
            _padding(),
            ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(15.0)),
              child:
              Image.network('http://daitunglamhoasen.org/assets/image/slider/1.jpg'),
            ),
            _padding(),
            Text(
              '"Buông xả mọi phiền não trong cuộc sống để tâm bình an là niềm hạnh phúc lớn nhất của mỗi người."',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto"
              ),
            ),
            Text(
              'Lời Phật Dạy',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 22,
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
            _padding(),
            ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(15.0)),
              child:
              Image.network('http://daitunglamhoasen.org/assets/image/slider/2.jpg'),
            ),
            _padding(),
            Text(
              '"Hãy tự mình thắp đuốc lên mà đi - Hãy nương vào Tứ Niệm Xứ để tu tập."',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto"
              ),
            ),
            Text(
              'Lời Phật Dạy',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 22,
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
            _padding(),
            ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(15.0)),
              child:
              Image.network('http://daitunglamhoasen.org/assets/image/slider/3.jpg'),
            ),
          ],
        ),
      ),
    );
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
}
