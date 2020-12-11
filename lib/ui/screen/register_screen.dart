import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/auth_bloc.dart';
import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/ui/widget/loading_indication.dart';
import 'package:mobispartsearch/ui/widget/register_form.dart';
import 'package:mobispartsearch/utils/navigation.dart';

import 'id_login_screen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void messageBox(String string){
      showDialog(context: context, builder: (context){
        return AlertDialog(content: Text(string),);
      });
    }

    return BlocListener<AuthBloc, AuthState>(
      cubit: BlocProvider.of<AuthBloc>(context),
      listener: (BuildContext context, state) {
        if (state.signUpSucc) {
          BlocProvider.of<AuthBloc>(context).add(AuthEventSignIn(id: state.id, password: state.password));
          pushTo(context, IdLoginScreen());
        }
//        if(state.errorMsg != '')
//          showToastMessage(text:state.errorMsg, position: 1);
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        cubit: BlocProvider.of<AuthBloc>(context),
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              leading: BackButton(color: Colors.black),
              title: Text(
                '회원가입',
                style: TextStyle(
                  fontFamily: 'HDharmony',
                ),
              ),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                RegisterForm(), //
                Positioned(
                  child: LoadingIndicator(isLoading: state.isLoading),//
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
