import 'package:flutter/material.dart';
import 'package:instagram_two_record/screens/profile_screen.dart';
import 'package:instagram_two_record/widgets/FadeStack.dart'; //지금은 안
import 'package:instagram_two_record/widgets/comment.dart';
import 'package:instagram_two_record/widgets/sign_in_form.dart';
import 'package:instagram_two_record/widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  //sign out 하면
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin { //with "singleTickerProvie //MUST IN when have to use AnimationController
  Widget signUpForm = SignUpForm(); //이전의 sign in/out 바꾸는 방법
  Widget signInForm = SignInForm(); //그러나 이 방법은 화면에서 내용을 그대로 저장하고 있지 않는다
  Widget currentWidget; //따라서 IndexedStack 과 widgetList를 사용해서 화면을 바꿔준다

  @override
  void initState() {
    if(currentWidget == null){
      currentWidget = signUpForm;
    }
    // TODO: implement initState

    super.initState();
  }


  int selectedForm = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        //핸드폰 맨 위에 적당한 간격이 생기게 해줌
        child: Stack(
          children: [
            AnimatedSwitcher( //안에 있는 transitionBuilder 옵션으로 원하는 애니메이션 만들 수 있
              child: currentWidget,
              duration: duration,
            ),
            Positioned(
              left: 0, // gap: 0
              right: 0,
              bottom: 0,
              height: 40,// 아래로 옴
              child: Container(
                color: Colors.white,
                child: FlatButton(
                  shape: Border(top: BorderSide(color: Colors.grey)),
                  onPressed: () {
                    setState(() {
                      if (currentWidget is SignUpForm) {
                        // if( a is A ) a = instance / A = class
                        currentWidget = signInForm;
                      } else {
                        currentWidget = signUpForm;
                      }
                    });
                  },
                  child: RichText(
                      text: TextSpan(
                          text: (currentWidget is SignUpForm)? "Already have an account? " : "Don't have an account? ",
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                                text: (currentWidget is SignUpForm)? "Sign In " : "Sign Up",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                )
                            )
                          ]
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
