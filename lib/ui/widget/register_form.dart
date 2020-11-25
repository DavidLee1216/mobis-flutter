import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobispartsearch/bloc/auth_bloc.dart';
import 'package:mobispartsearch/model/user_model.dart';
import 'package:mobispartsearch/common.dart';

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

  int seq = -1;

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
        contentPadding: EdgeInsets.only(left: 10),
      ),
      obscureText: true,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
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
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      validator: (value) => value.isEmpty ? "암호를 다시 입력하세요." : null,
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
          if (await checkUsername(_idController.text) == false) {
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
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      validator: (value) => value.isEmpty ? "이메일을 입력하세요." : null,
      controller: _emailController,
    );

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
          if (await checkEmail(_emailController.text) == false) {
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
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
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

    var phoneNumberField = TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.number,
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      validator: (value) => value.isEmpty ? "휴대폰 번호를 입력하세요." : null,
      controller: _phoneNumberController,
    );

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
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      controller: _authNumberVerifyController,
    );

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
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
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
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
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
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
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
      style: TextStyle(fontFamily: 'HDharmony', fontSize: 16.0),
      controller: _carNumber2Controller,
    );

    var registerButton = Container(
      padding: EdgeInsets.only(left: 9.0, right: 9.0),
      height: 60,
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
          await registerUser(
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
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: passField,
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
}
