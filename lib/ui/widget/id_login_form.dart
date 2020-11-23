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
        height: 60,
        width: 380,
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),

            filled: true,
            fillColor: Colors.white,
//                  contentPadding: EdgeInsets.only(left: 30, ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),

            hintText: '아이디',
          ),
          keyboardType: TextInputType.text,
          validator: (value) => value.isEmpty ? "아이디를 입력하세요." : null,
          style: TextStyle(
            fontSize: 16.0,
          ),
          controller: _idController,
        ));

    var passwordField = Container(
      height: 60,
      width: 380,
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
//                  contentPadding: EdgeInsets.only(left: 30, ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          hintText: '비밀번호',
        ),
        obscureText: true,
        validator: (value) => value.isEmpty ? "비밀번호를 입력하세요." : null,
        style: TextStyle(fontSize: 16.0),
        controller: _passwordController,
      ),
    );

    Future<void> signIn(String username, String password) async {
      if (_formKey.currentState.validate()) {
        FocusScope.of(context).requestFocus(FocusNode());
        if (await bloc.userRepository.signIn(username, password) == true) {
          bloc.add(AuthEventSignIn(
            id: username,
            password: password,
          ));
          pushTo(
              context,
              NavigationBar(
                index: 1,
              ));
        }
      }
    }

    onLoginButtonPressed() {
      signIn(_idController.text, _passwordController.text);
    }

    onRegisterButtonPressed() {
      pushTo(context, RegisterScreen());
    }

    onGetPassButtonPressed() {
      pushTo(context, GetPassScreen());
    }

    var loginButton = Container(
      width: 380,
      height: 60,
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: Color.fromRGBO(0, 63, 114, 1),
        child: Text(
          '로그인 하기',
          style: TextStyle(fontSize: 18, color: Colors.white),
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
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(7, 75, 136, 1),
              ),
            ),
          ),
        ));

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
        padding: const EdgeInsets.all(10.0),
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
                height: 10,
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
