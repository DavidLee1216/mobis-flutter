import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/widget/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return BlocListener<AuthBloc, AuthState>(
//      cubit: BlocProvider.of<AuthBloc>(context),
//      listener: (BuildContext context, state) {
//        if (state.isAuthenticated()) {
//          Navigator.of(context).pushReplacementNamed('/home');
//          return;
//        }
//      },
//      child: BlocBuilder<AuthBloc, AuthState>(
//          cubit: BlocProvider.of<AuthBloc>(context),
//          builder: (context, state) {
//            return Scaffold(
//              resizeToAvoidBottomPadding: false,
//              appBar: AppBar(title: Text('로그인')),
//              body: Stack(
//                children: [
//                  LoginForm(),//
//                ],
//              ),
//            );
//          }),
//    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          LoginForm(),
        ],
      ),
    );
  }
}
