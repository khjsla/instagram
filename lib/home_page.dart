
import 'package:flutter/material.dart';
import 'package:instagram_two_record/screens/feed_screen.dart';
import 'package:instagram_two_record/screens/profile_screen.dart';

import 'constants/screen_size.dart';

class HomePage extends StatefulWidget { //Stateless -> Stateful 안하면 아무리 화면 터치해도 안바뀜
  HomePage({ //const 있으면 변화하게 된다고 빨간줄 뜸 - const 없애주면 됨
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
  //magic key [Option + Enter] 로 stateless -> stateful easily
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label:'home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label:'search'),
    BottomNavigationBarItem(icon: Icon(Icons.add), label:'add'),
    BottomNavigationBarItem(icon: Icon(Icons.gamepad), label:'gamepad'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label:'person')
    //한번에 -> option + drag
    //middle line => 이제 지원 안한다. command + click 으로 대신 사용해야 되는 걸 확인후,
    //형식에 맞춰 사용하도록 하면 됨
    //label 꼭 있어야 함 !
  ];

  int _selectedIndex = 0;

 static List<Widget> _screens = <Widget>[
    FeedScreen(),
    Container(color: Colors.blueAccent),
    Container(color: Colors.greenAccent),
    Container(color: Colors.deepPurpleAccent),
    ProfileScreen(),
    //Command + D 해당 줄을 아래로 그대로 복사
  ];

  @override
  Widget build(BuildContext context) {
    if(size == null){
      size = MediaQuery.of(context).size;
    }
    return Scaffold( //Scaffold 안에 기본적인 틀 들이 들어있다
        body: IndexedStack( //1 container to Widget List
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
        onTap: _onBtmItemClick,
      ),
    );
  }

  void _onBtmItemClick(int index){
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}