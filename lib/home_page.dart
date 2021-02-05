//import 'dart:html';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/screens/camera_screen.dart';
import 'package:instagram_two_record/screens/feed_screen.dart';
import 'package:instagram_two_record/screens/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'constants/screen_size.dart';

class HomePage extends StatefulWidget {
  //Stateless -> Stateful 안하면 아무리 화면 터치해도 안바뀜
  HomePage({
    //const 있으면 변화하게 된다고 빨간줄 뜸 - const 없애주면 됨
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
//magic key [Option + Enter] 로 stateless -> stateful easily
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
    BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'gamepad'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person')
    //한번에 -> option + drag
    //middle line => 이제 지원 안한다. command + click 으로 대신 사용해야 되는 걸 확인후,
    //형식에 맞춰 사용하도록 하면 됨
    //label 꼭 있어야 함 !
  ];

  int _selectedIndex = 0;
  //**** snack bar 는 꼭 Scaffold 안에서 사용해줘야해
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static List<Widget> _screens = <Widget>[
    FeedScreen(),
    Container(
      color: Colors.blueAccent,
    ),
    Container(
      //to camera screen
      color: Colors.greenAccent,
    ),
    Container(
      color: Colors.deepPurpleAccent,
    ),
    ProfileScreen(),
    //Command + D 해당 줄을 아래로 그대로 복사
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size;
    }
    return Scaffold(
      key: _key, //** scaffold 안에서 Snackbar 를 사용해줘야 한다 **
      //Scaffold 안에 기본적인 틀 들이 들어있다
      body: IndexedStack(
        //1 container to Widget List
        index: _selectedIndex,
        children: _screens, // [] == List<Widget>
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onBtmItemClick, //how to handle Screen Where to go
      ),
    );
  }

  void _onBtmItemClick(int index) {
    switch (index) {
      case 2:
        _openCamera(); //to Method
        // is to go other screen
        // 그냥 외워
        break;
      default:
        {
          print(index);
          setState(() {
            _selectedIndex = index;
          });
        }
    }
  }

  void _openCamera() async {
    //permission TRUE 해야, 카메라 사용가능 하도록
    if (await checkIfPermissionGranted(context))
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    else {
      SnackBar snackBar = SnackBar(
        content: Text('사진, 파일, 마이크 접근 허용을 해주셔야 카메라 사용이 가능합니다'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            _key.currentState.hideCurrentSnackBar();//scaffold 안에서 선언된 _key 를 사
            //Scaffold context 가져와야
            AppSettings.openAppSettings(); //app 설정 페이지가 열리게 된
         },
        ),
      );
     _key.currentState.hideCurrentSnackBar(); //Scaffold 안에서 선언된걸 사용할 수 있다
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.camera, Permission.microphone].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) {
        permitted = false;
      }
    });

    return permitted;
  } //future async await very BASIC FORM

}
