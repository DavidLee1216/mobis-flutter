import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/auth_bloc.dart';
import 'package:mobispartsearch/ui/screen/home_screen.dart';
import 'package:mobispartsearch/ui/widget/id_login_form.dart';
import 'package:mobispartsearch/ui/widget/loading_indication.dart';
import 'package:mobispartsearch/ui/widget/navigation_bar.dart';
import 'package:mobispartsearch/utils/navigation.dart';

class IdLoginScreen extends StatelessWidget {
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
        if (state.id != '') {
          pushTo(context, NavigationBar(index: 1));
          return;
        }
        if(state.errorMsg != '')
          messageBox(state.errorMsg);
      },
      child: BlocBuilder<AuthBloc, AuthState>(
          cubit: BlocProvider.of<AuthBloc>(context),
          builder: (context, state) {
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
                  Positioned(
                    child: LoadingIndicator(isLoading: state.isLoading),//
                  ),
                ],
              ),
            );
      }),
    );
  }
}
