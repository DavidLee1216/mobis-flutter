import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/auth_bloc.dart';
import 'package:mobispartsearch/model/user_model.dart';
import 'package:mobispartsearch/common.dart';
import 'package:kopo/kopo.dart';

enum Gender { male, female }

class RegisterForm extends StatefulWidget {
//  final String errorMsg;

//  const RegisterForm({Key key, this.errorMsg}) : super(key: key);

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

  int seq = -1;
  bool authConfirmed = false;

  var postCode = '';

  LoginType loginType = LoginType.NONE;
  String gmail = '';

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

  messageBox(String string) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(string),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = BlocProvider.of<AuthBloc>(context);
    Future<void> registerUser(
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
      if (_formKey.currentState.validate() && seq != -1) {
        //
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
        bloc.add(AuthEventSignUp(user: user));
      } else if (seq == -1) {
        showToastMessage(text: '인증번호를 확인하세요.', position: 1);
      }
    }

    DateTime selectedDate = DateTime.now();
    var idField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      validator: (value) => value.isEmpty ? "아이디를 입력하세요." : null,
      controller: _idController,
    );

    var passField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      obscureText: true,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      validator: (value) => value.isEmpty
          ? "암호를 입력하세요."
          : validatePassword(value)
              ? null
              : "8-20자의 영문 대/소문자, 숫자, 특수문자 중 3가지 이상 혼용하여 입력해주세요.",
      controller: _passwordController,
    );

    var repassField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      obscureText: true,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      validator: (value) => value.isEmpty
          ? "암호를 다시 입력하세요."
          : validatePassword(value)
              ? null
              : "8-20자의 영문 대/소문자, 숫자, 특수문자 중 3가지 이상 혼용하여 입력해주세요.",
      controller: _repasswordController,
    );

    var idDupConfirmButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 4,
      height: 50,
      buttonColor: Colors.white,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('중복확인',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'HDharmony',
              color: kPrimaryColor,
            )),
        onPressed: () async {
          if (await checkUsername(_idController.text.trim()) == false) {
            showToastMessage(text: '아이디가 이미 등록되여 있습니다.', position: 1);
          } else {
            showToastMessage(text: "사용할수 있는 아이디입니다.", position: 1);
          }
        },
      ),
    );

    var emailField = (loginType == LoginType.NONE) ? TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      validator: (value) => value.isEmpty
          ? "이메일을 입력하세요."
          : validateEmailString(value)
              ? null
              : "이메일을 확인해주세요.",
      controller: _emailController,
    ) : FocusScope(
        node: new FocusScopeNode(),
        child: new TextFormField(
          enabled: false,
          style: TextStyle(
              fontFamily: 'HDharmony',
              color: Colors.black26,
              fontSize: 16.0),
          decoration: new InputDecoration(
            hintText: gmail,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
        ));

    var emailDupConfirmButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 4,
      height: 50,
      buttonColor: Colors.white,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('중복확인',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'HDharmony',
              color: kPrimaryColor,
            )),
        onPressed: () async {
          if(_emailController.text.trim().isEmpty){
            showToastMessage(text: '이메일을 입력하세요.', position: 1);
          }else if (await checkEmail(_emailController.text.trim()) == false) {
            showToastMessage(text: '이메일이 이미 등록되여 있습니다.', position: 1);
          } else {
            showToastMessage(text: '사용할수 있는 이메일입니다.', position: 1);
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      validator: (value) => value.isEmpty ? "이름을 입력하세요." : null,
      controller: _nameController,
    );

    Future<void> _selectedDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        locale: const Locale("ko", "KR"),
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      validator: (value) => value.isEmpty ? "생일을 입력하세요." : null,
      controller: _birthdayController,
      onTap: () => _selectedDate(context),
    );

    var maleRadio = Row(
      children: [
        const Text(
          '남자',
          style: TextStyle(
              fontFamily: 'HDharmony', fontSize: 16, color: Colors.black),
        ),
        Radio(
          value: Gender.male,
          groupValue: _gender,
          onChanged: (Gender value) {
            setState(() {
              _gender = value;
              sexCode = 'M';
            });
          },
        )
      ],
    );

    var femaleRadio = Row(
      children: [
        const Text(
          '여자',
          style: TextStyle(
              fontFamily: 'HDharmony', fontSize: 16, color: Colors.black),
        ),
        Radio(
          value: Gender.female,
          groupValue: _gender,
          onChanged: (Gender value) {
            setState(() {
              _gender = value;
              sexCode = 'F';
            });
          },
        )
      ],
    );

    var phoneNumberField = !authConfirmed
        ? TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              contentPadding: EdgeInsets.only(left: 10),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
            validator: (value) => value.isEmpty
                ? "휴대폰 번호를 입력하세요."
                : validateMobileString(value)
                    ? null
                    : "휴대폰 번호를 확인해주세요.",
            controller: _phoneNumberController,
          )
        : FocusScope(
            node: new FocusScopeNode(),
            child: new TextFormField(
              enabled: false,
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  color: Colors.black26,
                  fontSize: 16.0),
              decoration: new InputDecoration(
                hintText: _phoneNumberController.text,
              ),
            ));

    var phoneAuthGetButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 4,
      height: 50,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text(
          '인증번호 받기',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'HDharmony',
            color: kPrimaryColor,
          ),
        ),
        onPressed: () async {
          await validateSMS(_phoneNumberController.text);
          showToastMessage(text: '인증번호가 발송되었습니다.', position: 1);
        },
      ),
    );

    var phoneAuthField = !authConfirmed
        ? TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              contentPadding: EdgeInsets.only(left: 10),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
            controller: _authNumberVerifyController,
          )
        : FocusScope(
            node: new FocusScopeNode(),
            child: new TextFormField(
              enabled: false,
              style: TextStyle(
                  fontFamily: 'HDharmony',
                  color: Colors.black26,
                  fontSize: 16.0),
              decoration: new InputDecoration(
                hintText: _authNumberVerifyController.text,
              ),
            ));

    var phoneAuthConfirmButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 4,
      height: 50,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('인증번호 확인',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'HDharmony',
              color: kPrimaryColor,
            )),
        onPressed: () async {
          seq = await validateCode(_authNumberVerifyController.text);
          if (seq == -1) {
            showToastMessage(text: '인증번호가 일치하지 않습니다.', position: 1);
          } else {
            showToastMessage(text: '인증번호가 확인되었습니다.', position: 1);
            setState(() {
              authConfirmed = true;
            });
//            phoneNumberField.enabled = false;
          }
        },
      ),
    );

    var address1Field = TextField(
      readOnly: true,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      controller: _address1Controller,
    );

    var address2Field = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      controller: _address2Controller,
    );

    var address3Field = TextField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          contentPadding: EdgeInsets.only(left: 10),
          hintText: '상세주소'),
      keyboardType: TextInputType.text,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      controller: _address3Controller,
    );

    var postSearchButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width / 4,
      height: 50,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('우편번호 검색',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'HDharmony',
              color: kPrimaryColor,
            )),
        onPressed: () async {
          KopoModel kopoModel = await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Kopo(),
            ),
          );
          if (kopoModel != null) {
            setState(() {
              _address1Controller.text = kopoModel.zonecode;
              _address2Controller.text = kopoModel.address;
            });
          }
        },
      ),
    );

    var carNumber1Field = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      controller: _carNumber1Controller,
    );

    var carNumber2Field = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      controller: _carNumber2Controller,
    );

    var registerButton = Container(
      padding: EdgeInsets.only(left: 9.0, right: 9.0),
      height: 50,
      child: RaisedButton(
        color: kPrimaryColor,
        child: Text(
          '가입하기',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'HDharmony',
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        onPressed: () async {
          if (_passwordController.text == _repasswordController.text)
            await registerUser(
                _idController.text.trim(),
                _phoneNumberController.text.trim(),
                _emailController.text.trim(),
                encryptPassword(_passwordController.text.trim()),
                _nameController.text.trim(),
                _birthday,
                sexCode,
                _address1Controller.text.trim(),
                _address2Controller.text.trim(),
                _address3Controller.text.trim(),
                _carNumber1Controller.text.trim(),
                _carNumber2Controller.text.trim());
          else
            showToastMessage(text: '비밀번호가 일치하지 않습니다.', position: 1);
        },
      ),
    );

    return BlocBuilder<AuthBloc, AuthState>(
      cubit: BlocProvider.of<AuthBloc>(context),
      builder: (BuildContext context, state) {
        if(state.loginType==LoginType.GOOGLE)
        {
          loginType = LoginType.GOOGLE;
          gmail = googleUser.email;
          _emailController.text = gmail;
        }
        return Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      '아이디',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
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
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '비밀번호',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: passField,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '비밀번호 확인',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: repassField,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          size: 20,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            '8~20자의 영문 대/소문자, 숫자, 특수문자 중 3가지 이상 혼용하여 입력해주세요.',
                            style: TextStyle(
                                fontFamily: 'HDharmony',
                                color: kPrimaryColor,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '이메일',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
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
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '이름',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: nameField,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '생년월일',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: birthdayField,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '성별',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      maleRadio,
                      SizedBox(
                        width: 50,
                      ),
                      femaleRadio,
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '휴대폰',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
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
                  height: 5,
                ),
                Container(
                  height: 50,
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          size: 20,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '공백 특수기호 없이 특수문자만 입력하세요',
                          style: TextStyle(
                              fontFamily: 'HDharmony',
                              color: kPrimaryColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '주소',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
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
                  height: 5,
                ),
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: address2Field,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: address3Field,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '차량번호(옵션)',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: carNumber1Field,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '차대번호(옵션)',
                      style: TextStyle(
                        fontFamily: 'HDharmony',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
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
          ),
        );
      }
    );
  }
}
