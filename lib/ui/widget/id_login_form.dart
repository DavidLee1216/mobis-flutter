import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:hyundai_mobis/bloc/auth_bloc.dart';
import 'package:hyundai_mobis/ui/screen/pass_reset_screen.dart';
import 'package:hyundai_mobis/ui/screen/register_screen.dart';
import 'package:hyundai_mobis/ui/widget/loading_indication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/utils/navigation.dart';
import 'package:hyundai_mobis/ui/screen/home_screen.dart';

import 'navigation_bar.dart';
import 'package:hyundai_mobis/common.dart';

class IdLoginForm extends StatefulWidget {
  final String errorMsg;

  const IdLoginForm({Key key, this.errorMsg}) : super(key: key);

  @override
  _IdLoginFormState createState() => _IdLoginFormState();
}

class _IdLoginFormState extends State<IdLoginForm> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = BlocProvider.of<AuthBloc>(context);

    var idField = Container(
        height: 40,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
//                  contentPadding: EdgeInsets.only(left: 30, ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            contentPadding: EdgeInsets.only(left: 10),
            hintText: '아이디',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => value.isEmpty ? "아이디를 입력하세요." : null,
          style: TextStyle(fontSize: 16.0,),
          controller: _idController,
        ));

    var passwordField = Container(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
//                  contentPadding: EdgeInsets.only(left: 30, ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              contentPadding: EdgeInsets.only(left: 10),
              hintText: '비밀번호',
            ),
            obscureText: true,
            validator: (value) => value.isEmpty ? "비밀번호를 입력하세요." : null,
            style: TextStyle(fontSize: 16.0),
            controller: _passwordController,
          ),
        ));

    onLoginButtonPressed() {
      if (_formKey.currentState.validate()) {
        FocusScope.of(context).requestFocus(FocusNode());
        http.post(API+'signin', body: {'username':_idController.text, 'password':_passwordController.text}).then((value) {
          if(value.statusCode==200) {
            bloc.add(AuthEventSignIn(
              id: _idController.text,
              password: _passwordController.text,
            ));
            pushTo(context, NavigationBar(index: 1,));
          }
        });
      }
    }

    onRegisterButtonPressed() {
      pushTo(context, RegisterScreen());
    }

    onGetPassButtonPressed() {
      pushTo(context, GetPassScreen());
    }

    var loginButton = Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 40,
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Color.fromRGBO(0, 63, 114, 1),
        child: Text(
          '로그인하기',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: onLoginButtonPressed,
      ),
    );

    var registerButton = Container(
         height: 40,
         child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FlatButton(
            onPressed: onRegisterButtonPressed,
            child: Text(
              '회원가입',
              style: TextStyle(fontSize: 16, color: Colors.indigo),
            ),
            color: Colors.white,
          ),
       )
    );

    var getPassButton = Container(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FlatButton(
            onPressed: onGetPassButtonPressed,
            child: Text(
              '비밀번호 찾기',
              style: TextStyle(fontSize: 16, color: Colors.indigo),
            ),
            color: Colors.white,
          ),
        )
    );

//    var errorMessageField = widget.errorMsg.isNotEmpty
//        ? Padding(
//      padding: EdgeInsets.all(32.0),
//      child: Text(
//        widget.errorMsg,
//        style: TextStyle(color: Colors.red),
//      ),
//    )
//        : Container();

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              idField,
              SizedBox(
                height: 20,
              ),
              passwordField,
              SizedBox(
                height: 20,
              ),
              loginButton,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 100),
                  ),
                  registerButton,
                  getPassButton,
                ],
              )
//              errorMessageField,
            ],
          ),
        ),
      ),
    );
  }
}
