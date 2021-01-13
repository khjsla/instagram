import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/auth_input_decor.dart';
import 'package:instagram_two_record/constants/common_size.dart';
import 'package:instagram_two_record/home_page.dart';
import 'package:instagram_two_record/widgets/or_divider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //TextFormEdit 사용할 때
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    //dispose 해줘야 memory leak 안생
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        //Scaffold - not child but body
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            //scroll 가능
            children: [
              SizedBox(
                height: common_l_gap,
              ),

              ///높이 이만큼
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('Email'),
                validator: (text) {
                  if (text.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세용 :)';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),

              ///높이 이만큼
              TextFormField(
                controller: _pwController,
                cursorColor: Colors.black54,
                obscureText: true,
                //for 비김밀번호 숨
                decoration: textInputDecor('Password'),
                validator: (text) {
                  if (text.isNotEmpty && text.length > 5) {
                    return null;
                  } else {
                    return '제대로된 비밀번호를 입력해주세용 :)';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),

              ///높이 이만큼
              TextFormField(
                controller: _cpwController,
                cursorColor: Colors.black54,
                obscureText: true,
                //for 비김밀번호 숨
                decoration: textInputDecor('Confirm Password'),
                validator: (text) {
                  if (text.isNotEmpty && _pwController.text == text) {
                    return null;
                  } else {
                    return '일치하는 비밀번호를 입력해주세용 :)';
                  }
                },
              ),
              SizedBox(
                height: common_s_gap,
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap,
              ),
              OrDivider(),
              FlatButton.icon(
                  onPressed: () {},
                  textColor: Colors.blue,
                  icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                  label: Text("Login with Facebook"))
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          print('validation success!');
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
      child: Text(
        'Join',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6)),
    );
  }
}


