import 'package:hyundai_mobis/bloc/auth_bloc.dart';
import 'package:hyundai_mobis/ui/widget/loading_indication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    var idField = TextFormField(
      decoration: InputDecoration(
        hintText: '아이디',
      ),
      keyboardType: TextInputType.text,
      validator: (value) => value.isEmpty ? "아이디를 입력하세요." : null,
      controller: _idController,
    );

    var passwordField = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: '비밀번호',
        ),
        obscureText: true,
        validator: (value) => value.isEmpty ? "비밀번호를 입력하세요." : null,
        controller: _passwordController,
      ),
    );

    onLoginButtonPresed() {
//      if (_formKey.currentState.validate()) {
//        FocusScope.of(context).requestFocus(FocusNode());
//        bloc.add(AuthEventSignIn(
//          id: _idController.text,
//          password: _passwordController.text,
//        ));
//      }
      Navigator.of(context).pushNamed('/home');
    }

    onRegisterButtonPressed() {
      Navigator.of(context).pushNamed('/register');
    }

    var loginButton = Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.indigo,
        child: Text(
          '로그인하기',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: onLoginButtonPresed,
      ),
    );

    var registerButton = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FlatButton(
        onPressed: onRegisterButtonPressed,
        child: Text('회원가입',
          style: TextStyle(fontSize: 16, color: Colors.indigo),
        ),
        color: Colors.white,
      ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              idField,
              passwordField,
              loginButton,
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 100),),
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
