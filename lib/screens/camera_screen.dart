import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 1; //to make navigation bar first -> 1
  PageController _pageController = PageController(initialPage: 1); //1 is main page (current middle)
  String _title  = "Photo";

  @override
  void dispose() { //to prevent from memory leak
    // TODO: implement dispose
    _pageController.dispose(); //to ..
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title), //to make back button
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          //widet 인 children
          Container(
            color: Colors.cyanAccent,
          ),
          Container(
            color: Colors.amberAccent,
          ),
          Container(
            color: Colors.greenAccent,
          ),
        ],
        onPageChanged: (index) {
          //print('page changed = $index');
          setState(() {
            _currentIndex = index;
            switch (_currentIndex) {
              case 0:
                _title = 'Gallery';
                break;
              case 1:
                _title = 'Photo';
                break;
              case 2:
                _title = 'Video';
                break; //to change
            }
          });
        },
      ), // [Container -> Scaffold]to add Bottom Navigation bar
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 0,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked), label: "GALLERY"),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked), label: "PHOTO"),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked), label: "VIDEO"),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTabbed, //to method
      ),
    );
  }

  void _onItemTabbed(int index) {
    print(index);
    setState(() {
      //to change state
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}
