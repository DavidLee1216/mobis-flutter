import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hyundai_mobis/model/user_model.dart';
import 'package:hyundai_mobis/repository/user_repository.dart';
import 'package:hyundai_mobis/ui/screen/id_login_screen.dart';
import 'package:hyundai_mobis/ui/screen/login_screen.dart';
import 'package:hyundai_mobis/ui/widget/navigation_bar.dart';
import 'package:hyundai_mobis/utils/navigation.dart';
import 'package:hyundai_mobis/common.dart';

enum Gender { male, female }

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  Gender _gender = Gender.male;
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _authNumberVerifyController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _address3Controller = TextEditingController();
  final _carNumber1Controller = TextEditingController();
  final _carNumber2Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String sexCode = 'M';

  String _birthday = '';

  String seq = '';

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _birthdayController.dispose();
    _phoneNumberController.dispose();
    _authNumberVerifyController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _address3Controller.dispose();
    _carNumber1Controller.dispose();
    _carNumber2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = BlocProvider.of<AuthBloc>(context);

    Future<void> register_user(
        String id,
        String mobile,
        String email,
        String password,
        String legalName,
        String dateOfBirth,
        String sexCode,
        String zipcode,
        String address,
        String addressExtended,
        String vin,
        String vlp) async {
      if (_formKey.currentState.validate() && seq != '') {
        User user = User(
            address: address,
            addressExtended: addressExtended,
            dateofBirth: dateOfBirth,
            email: email,
            gtoken: '',
            ktoken: '',
            legalName: legalName,
            mobile: mobile,
            ntoken: '',
            password: password,
            sexCode: sexCode,
            username: id,
            vin: vin,
            vlp: vlp,
            zipcode: zipcode);
        if (await bloc.userRepository.signUp(user) == true)
          Navigator.of(context).pop();
      }
    }

    DateTime selectedDate = DateTime.now();
    var idField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      validator: (value) => value.isEmpty ? "아이디를 입력하세요." : null,
      controller: _idController,
    );

    var passField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      obscureText: true,
      style: TextStyle(fontSize: 16.0),
      validator: (value) => value.isEmpty ? "암호를 입력하세요." : null,
      controller: _passwordController,
    );

    var repassField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      obscureText: true,
      style: TextStyle(fontSize: 16.0),
      validator: (value) => value.isEmpty ? "암호를 다시 입력하세요." : null,
      controller: _repasswordController,
    );

    var idDupConfirmButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 6,
      height: 40,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('중복확인',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
            )),
        onPressed: () {
          if (check_username(_idController.text) == false) {
//            _idController.clear();
          }
        },
      ),
    );

    var emailField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 16.0),
      validator: (value) => value.isEmpty ? "이메일을 입력하세요." : null,
      controller: _emailController,
    );

    var emailDupConfirmButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 5,
      height: 40,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('중복확인',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
            )),
        onPressed: () {
          if (check_email(_emailController.text) == false) {
//            _emailController.clear();
          }
        },
      ),
    );

    var nameField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      validator: (value) => value.isEmpty ? "이름을 입력하세요." : null,
      controller: _nameController,
    );

    Future<void> _selectedDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050),
//        initialEntryMode: DatePickerEntryMode.input,
      );
      if (picked != null && selectedDate != picked) {
        setState(() {
          selectedDate = picked;
        });
      }
      _birthdayController.text = selectedDate.year.toString() +
          "년" +
          selectedDate.month.toString() +
          "월" +
          selectedDate.day.toString() +
          "일";
      _birthday = selectedDate.year.toString() +
          selectedDate.month.toString() +
          selectedDate.day.toString();
    }

    var birthdayField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 16.0),
      validator: (value) => value.isEmpty ? "생일을 입력하세요." : null,
      controller: _birthdayController,
      onTap: () => _selectedDate(context),
    );

    var maleRadio = ListTile(
      title: const Text(
        '남자',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      leading: Radio(
        value: Gender.male,
        groupValue: _gender,
        onChanged: (Gender value) {
          setState(() {
            _gender = value;
            sexCode = 'M';
          });
        },
      ),
    );

    var femaleRadio = ListTile(
      title: const Text(
        '여자',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      leading: Radio(
        value: Gender.female,
        groupValue: _gender,
        onChanged: (Gender value) {
          setState(() {
            _gender = value;
            sexCode = 'F';
          });
        },
      ),
    );

    var phoneNumberField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 16.0),
      validator: (value) => value.isEmpty ? "휴대폰 번호를 입력하세요." : null,
      controller: _phoneNumberController,
    );

    var phoneAuthGetButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 4,
      height: 40,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text(
          '인증번호 받기',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        onPressed: () {
          validate_SMS(_phoneNumberController.text);
        },
      ),
    );

    var phoneAuthField = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      controller: _authNumberVerifyController,
    );

    var phoneAuthConfirmButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 4,
      height: 40,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('인증번호 확인',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
            )),
        onPressed: () {
          seq = validate_code(_authNumberVerifyController.text);
          seq = '123';
        },
      ),
    );

    var address1Field = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      controller: _address1Controller,
    );

    var address2Field = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      controller: _address2Controller,
    );

    var address3Field = TextField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          contentPadding: EdgeInsets.only(left: 10),
          hintText: '상세주소'),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      controller: _address3Controller,
    );

    var postSearchButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 4,
      height: 40,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('우편번호 검색',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
            )),
        onPressed: () {},
      ),
    );

    var carNumber1Field = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      controller: _carNumber1Controller,
    );

    var carNumber2Field = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      controller: _carNumber2Controller,
    );

    var registerButton = Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      height: 40,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text(
          '가입하기',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          await register_user(
              _idController.text,
              _phoneNumberController.text,
              _emailController.text,
              _passwordController.text,
              _nameController.text,
              _birthday,
              sexCode,
              _address1Controller.text,
              _address2Controller.text,
              _address3Controller.text,
              _carNumber1Controller.text,
              _carNumber2Controller.text);
        },
      ),
    );

    return Form(
      key: _formKey,
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '아이디',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: idField,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  idDupConfirmButton,
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '비밀번호',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: passField,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '비밀번호 확인',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: repassField,
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '이메일',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(child: emailField),
                  SizedBox(
                    width: 10,
                  ),
                  emailDupConfirmButton,
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '이름',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: nameField,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '생년월일',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: birthdayField,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '성별',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              maleRadio,
              femaleRadio,
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '휴대폰',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(child: phoneNumberField),
                  SizedBox(
                    width: 10,
                  ),
                  phoneAuthGetButton,
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: phoneAuthField,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  phoneAuthConfirmButton,
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: kPrimaryColor,
                  ),
                  Text(
                    '공백 특수기호 없이 특수문자만 입력하세요',
                    style: TextStyle(color: kPrimaryColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '주소',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: address1Field,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  postSearchButton,
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: address2Field,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: address3Field,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '차량번호(옵션)',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: carNumber1Field,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '차대번호(옵션)',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: carNumber2Field,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          registerButton,
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
