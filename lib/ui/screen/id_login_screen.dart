import 'package:flutter/material.dart';
import 'package:mobispartsearch/ui/widget/id_login_form.dart';

class IdLoginScreen extends StatelessWidget {
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
//                  IdLoginForm(errorMsg: state.errorMsg),//
//                  Positioned(
//                    child: LoadingIndicator(isLoading: state.isLoading),//
//                  ),
//                ],
//              ),
//            );
//          }),
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          '로그인',
          style: TextStyle(
            fontFamily: 'HDharmony',
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          IdLoginForm(),
        ],
      ),
    );
  }
}
