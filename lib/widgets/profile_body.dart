import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/constants/screen_size.dart';
import 'package:instagram_two_record/screens/profile_screen.dart';
import 'package:instagram_two_record/widgets/comment.dart';
import 'package:instagram_two_record/widgets/rounded_avartar.dart';

class ProfileBody extends StatefulWidget {

  final Function() onMenuChanged; //second.
  const ProfileBody({Key key, this.onMenuChanged}) : super(key: key); //make constructor!

  //to make change event, have to use STATEFUL ! not stateless
  //stateless -> stateful 변경은 꼭 rebuild 해줘야함 hot reload 하면 에러
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab =
      SelectedTab.left; // original: bool selected .. -> enum
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //widget_SafeArea : 너무 위에 뭐가 있는 경우에 쓰는 ,, 레이아웃이 시간 배터리 부분 제외하고 시작하도록 해준다!
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //이걸로 widget 의 위치를 정해줄 수 있다 중앙(기본위치) 에서 원하는 곳으로!
        children: [
          _appbar(),
          Expanded(
            //!!
            child: CustomScrollView(
              //check!!
              slivers: [
                // Q) what is slivers?? A)
                SliverList(
                  //이 형태를 그냥 외우면 됨 expanded ( custom - sliverlist - sliverchildlistdelegate )
                  delegate: SliverChildListDelegate([
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(common_gap), //위젯간 간격 8
                          child: RoundedAvatar(
                            size: 80, //프로필 사진 크기
                          ),
                        ),
                        Expanded(
                          //위 위젯 빼고 나머지 자리를 차지하게끔 - Expanded
                          child: Padding(
                            padding: const EdgeInsets.only(right: common_gap),
                            child: Table(
                              children: [
                                //widget list
                                TableRow(children: [
                                  //widget list
                                  _valueText('123123'),
                                  _valueText('213232'),
                                  _valueText('1223'),
                                ]),
                                TableRow(children: [
                                  //widget list
                                  _labelText('post'),
                                  _labelText('Followers'),
                                  _labelText('Following'),
                                ]),
                              ],
                            ),
                          ),
                        ) //** Q) What is Table?
                      ],
                    ),
                    _username(),
                    _userBio(),
                    _editProfileBtn(),
                    _tabButtons(),
                    _selectedIndicator(),
                  ]),
                ),
                //Sliver view인데 list 로 감싼것 =
                _imagesPager() //그리드 안에서는 스크롤러 무시 //몇칸인지 - 3 //가로세로비율 - 1
              ],
            ),
          ), //얘 제외 하고 나머지는 custom scroll view 로
        ],
      ),
    );
  }

  Row _appbar() {
    return Row(
      //좌우 아이템 나열 이므로 row
      children: [
        SizedBox(
          width: 44,
        ),
        Expanded(
          child: Text(
            'The Coding papa',
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            widget.onMenuChanged(); //third - just toggle ..
            //widget. 로 호출가능함을 기억하자
          },
        )
      ],
    );
  }

  Text _valueText(String value) => Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  Text _labelText(String label) => Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 11,
        ),
      );

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
        child: Stack(
      //wrap with Column and -> Stack
      children: [
        AnimatedContainer(
          //animation 효과
          duration: duration,
          transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
          //좌우만 신경쓰므로 x 값만 변화
          curve: Curves.fastOutSlowIn,
          child: _images(), //arranged.
        ),
        AnimatedContainer(
          //animation 효과
          duration: duration,
          //Q) what is matrix4 ?
          /* 0,0,0,0
                     0,0,0,0
                     0,0,0,0
                     0,0,0,0
                     form 의 matrix..
                  */
          transform: Matrix4.translationValues(
              _rightImagesPageMargin, 0, 0), //좌우만 신경쓰므로 x 값만 변화
          curve: Curves.fastOutSlowIn,
          child: _images(),
        ),
      ],
    ));
  }

  GridView _images() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      //GridView 안에서는 가만히 있고 스크롤 가능
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(
          30,
          (index) => CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "https://picsum.photos/id/$index/100/100")), //$blah - blah는 변수이다
    );
  }

  Widget _selectedIndicator() {
    //animation effect
    return AnimatedContainer(
      duration: Duration(microseconds: 300), //must have
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //1. 아래 버튼 두개가 적절하게 영역을 활용하면서(양쪽에 맞)춰 위치하게됨
      //2. or button 두개 동시에 expanded 감싸서 위와 똑같은 효과를 주게 됨
      children: [
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/images/grid.png'),
            color: _selectedTab == SelectedTab.left
                ? Colors.black
                : Colors.black26,
          ),
          onPressed: () {
            //to make change event, have to use STATEFUL ! not stateless
            _tabSelected(SelectedTab.left); //왼쪽이 선택 된 것이구나
          },
        ),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/images/saved.png'),
            color: _selectedTab == SelectedTab.left
                ? Colors.black26
                : Colors.black,
          ),
          onPressed: () {
            _tabSelected(SelectedTab.right);
          },
        ),
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          // TODO: Handle this case.
          _selectedTab = SelectedTab.left; //on pressed event
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = size.width;
          break;
        case SelectedTab.right:
          // TODO: Handle this case.
          _selectedTab = SelectedTab
              .right; //to make change event, have to use STATEFUL ! not stateless
          _leftImagesPageMargin = -size.width;
          _rightImagesPageMargin = 0;
          break;
      }
    });
  }
}

Padding _editProfileBtn() {
  return Padding(
    //2. padding 으로 겹치지 않고 예쁘게
    padding: const EdgeInsets.symmetric(
        horizontal: common_gap, vertical: common_xxs_gap),
    //hori : 양옆 padding , vert: 위아래 padding
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

enum SelectedTab {
  left,
  right
} //bool 로 플래그를 세워주는 것 보다 enum 을 정의해서 상황 설명을 제대로 해주는 게 좋다 for 협업
