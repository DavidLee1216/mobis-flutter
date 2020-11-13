import 'dart:async';
import 'dart:developer';
import 'package:hyundai_mobis/model/user_model.dart';
import 'package:hyundai_mobis/common.dart';

class UserRepository {

  UserRepository();

  Future<bool> signIn(String id, String password) =>
    signin(id, password);

  Future<bool> signUp(User user) =>
      signup(user);
}
