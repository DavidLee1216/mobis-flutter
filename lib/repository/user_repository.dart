import 'dart:async';
import 'dart:developer';
import 'package:mobispartsearch/model/user_model.dart';
import 'package:mobispartsearch/common.dart';

class UserRepository {

  UserRepository();

  Future<bool> signIn(String id, String password) =>
    signin(id, password);

  Future<bool> signUp(User user) =>
      signup(user);
}
