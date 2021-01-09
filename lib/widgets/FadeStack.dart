import 'package:flutter/material.dart';
import 'package:instagram_two_record/widgets/sign_in_form.dart';
import 'package:instagram_two_record/widgets/sign_up_form.dart';

class FadeStack extends StatefulWidget {
  final int selectedForm;
  const FadeStack({Key key, this.selectedForm}) : super(key: key); //do auto

  @override
  _FadeStackState createState() => _FadeStackState();
}

class _FadeStackState extends State<FadeStack> with SingleTickerProviderStateMixin{
  AnimationController _animationController; //animation controller 사용하려면 SingleTickerProviderStateMixin in 해야한다
  List<Widget> forms = [ SignUpForm(), SignInForm()];

  @override
  void initState() {
    // if(currentWidget == null){
    //   currentWidget = signUpForm;
    // }
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationController.forward(); //첫번쨰 화면을 처음에 보여주기 위해서
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FadeStack oldWidget) {
    // TODO: implement didUpdateWidget
    if(widget.selectedForm != oldWidget.selectedForm){
      _animationController.forward( from: 0.0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition( //have to with 'SingleTickerProviderStateMixin'
      opacity: _animationController,
      child: IndexedStack(
        children: forms, //list
        index: widget.selectedForm, //밖 class 에서..
      ),
    );
  }
}
