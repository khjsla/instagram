import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/constants/screen_size.dart';
import 'package:instagram_two_record/widgets/comment.dart';

class ProfileBody extends StatefulWidget { //to make change event, have to use STATEFUL ! not stateless
  //stateless -> stateful 변경은 꼭 rebuild 해줘야함 hot reload 하면 에러
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab = SelectedTab.left; // original: bool selected .. -> enum

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //!!
      child: CustomScrollView(
        //check!!
        slivers: [
          // Q) what is slivers?? A)
          SliverList(
            //이 형태를 그냥 외우면 됨 expanded ( custom - sliverlist - sliverchildlistdelegate )
          delegate: SliverChildListDelegate([
              _username(),
              _userBio(),
              _editProfileBtn(),
              _tabButtons(),
              _selectedIndicator(),
            ]),
          ), //Sliver view인데 list 로 감싼것 =
        ],
      ),
    );
  }

  Widget _selectedIndicator() { //animation effect
    return AnimatedContainer(
        duration: Duration(microseconds: 300), //must have
        alignment: _selectedTab == SelectedTab.left ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          height: 3,
          width: size.width / 2,
          color: Colors.black87,
        ),
      curve: Curves.easeInOut, //animation 효과 옵션
    );
  }

  Row _tabButtons() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, //1. 아래 버튼 두개가 적절하게 영역을 활용하면서(양쪽에 맞)춰 위치하게됨
              //2. or button 두개 동시에 expanded 감싸서 위와 똑같은 효과를 주게 됨
              children: [
                IconButton(
                    icon: ImageIcon(
                  AssetImage('assets/images/grid.png'),
                  color: _selectedTab == SelectedTab.left? Colors.black: Colors.black26,
                ),
                onPressed: (){
                      setState(() {
                        _selectedTab = SelectedTab.left; //on pressed event
                        //to make change event, have to use STATEFUL ! not stateless
                      });
                },),
                IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/images/saved.png'),
                    color: _selectedTab == SelectedTab.left? Colors.black26: Colors.black,
                  ),
                  onPressed: (){
                    setState(() {
                      _selectedTab = SelectedTab.right; //to make change event, have to use STATEFUL ! not stateless
                    });
                  },),
              ],
            );
  }
}

Padding _editProfileBtn() {
  return Padding(
    //2. padding 으로 겹치지 않고 예쁘게
    padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap), //hori : 양옆 padding , vert: 위아래 padding
    //horizontal: 양옆만 padding 을 준다
    child: SizedBox(
      //1. sized box로 높이 조절
      height: 24,
      child: OutlineButton(
        onPressed: () {},
        borderSide: BorderSide(color: Colors.black45),
        // border = Box의 outline
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), //둥글둥글한 정도 = radius
        ),
        child: Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget _username() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      'username',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget _userBio() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      'this is what i believe!',
      style: TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}

enum SelectedTab { left, right } //bool 로 플래그를 세워주는 것 보다 enum 을 정의해서 상황 설명을 제대로 해주는 게 좋다 for 협업