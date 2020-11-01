import 'package:flutter/material.dart';

enum Gender{male, female}
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


  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    DateTime selectedDate = DateTime.now();
    var idField = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      controller: _idController,
    );

    var passField = TextField(
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.circular(2),
     borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      contentPadding: EdgeInsets.only(left: 10),
    ),
    obscureText: true,
    style: TextStyle(fontSize: 16.0),
    controller: _passwordController,
      );

    var repassField = TextField(
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(2),
      borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      contentPadding: EdgeInsets.only(left: 10),
    ),
    obscureText: true,
    style: TextStyle(fontSize: 16.0),
    controller: _repasswordController,
    );

    var idDupConfirmButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width/5,
      height: 40,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('중복확인', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(0, 63, 114, 1),)),
        onPressed: () {},
      ),
    );

    var emailField = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 16.0),
      controller: _emailController,
    );

    var emailDupConfirmButton = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width/5,
      height: 40,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('중복확인', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(0, 63, 114, 1),)),
        onPressed: () {},
      ),
    );

    var nameField = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
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
      if(picked != null && selectedDate!=picked) {
        setState(() {
          selectedDate = picked;
        });
      }
      _birthdayController.text = selectedDate.year.toString()+"년 "+selectedDate.month.toString()+"월 "+selectedDate.day.toString()+"일";
    }

    var birthdayField = TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 16.0),
      controller: _birthdayController,
      onTap: ()=>_selectedDate(context),
    );

    var maleRadio = ListTile(
      title: const Text('남자', style: TextStyle(fontSize: 16, color: Colors.black),),
      leading: Radio(
        value: Gender.male,
        groupValue: _gender,
        onChanged: (Gender value){
          setState(() {
            _gender = value;
          });
        },
      ),
    );

    var femaleRadio = ListTile(
      title: const Text('여자', style: TextStyle(fontSize: 16, color: Colors.black),),
      leading: Radio(
        value: Gender.female,
        groupValue: _gender,
        onChanged: (Gender value){
          setState(() {
            _gender = value;
          });
        },
      ),
    );

    var phoneNumberField =  TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        contentPadding: EdgeInsets.only(left: 10),
      ),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 16.0),
      controller: _phoneNumberController,
    );

     var phoneAuthGetButton =   ButtonTheme(
       minWidth: MediaQuery.of(context).size.width/4,
       height: 40,
       buttonColor: Colors.white,
       child: RaisedButton(
         padding: EdgeInsets.only(left: 8.0),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(5.0),
           side: BorderSide(color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
         ),
         child: Text('인증번호 받기', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(0, 63, 114, 1),),),
         onPressed: () {},
       ),
     );

    var phoneAuthField =  TextField(
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

    var phoneAuthConfirmButton =  ButtonTheme(
      minWidth: MediaQuery.of(context).size.width/4,
      height: 40,
      buttonColor: Colors.white,
      child: RaisedButton(
        padding: EdgeInsets.only(left: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('인증번호 확인', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(0, 63, 114, 1),)),
        onPressed: () {},
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
        hintText: '상세주소'
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16.0),
      controller: _address3Controller,
    );

     var postSearchButton = ButtonTheme(
       minWidth: MediaQuery.of(context).size.width/4,
       height: 40,
       buttonColor: Colors.white,
       child: RaisedButton(
         padding: EdgeInsets.only(left: 8.0),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(5.0),
           side: BorderSide(color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
         ),
         child: Text('우편번호 검색', textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(0, 63, 114, 1),)),
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
        color: Color.fromRGBO(0, 63, 114, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.blueGrey, width: 1.0, style: BorderStyle.solid),
        ),
        child: Text('가입하기', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
        onPressed: () {},
      ),
    );

     return ListView(
       scrollDirection: Axis.vertical,
       shrinkWrap: true,
       padding: EdgeInsets.all(20),
       children: <Widget>
       [
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
        SizedBox(height: 10,),
        Container(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
            Row(
              children: [
                Expanded(child: idField,),
                SizedBox(width: 10,),
                idDupConfirmButton,
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
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
        SizedBox(height: 10,),
        Container(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: passField,
          ),
        ),
        SizedBox(height: 10,),
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
         SizedBox(height: 10,),
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
         SizedBox(height: 10,),
        Container(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(child: emailField),
                SizedBox(width: 10,),
                emailDupConfirmButton,
              ],
            ),
          ),
        ),
         SizedBox(height: 10,),
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
         SizedBox(height: 10,),
        Container(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: nameField,
          ),
        ),
         SizedBox(height: 10,),
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
         SizedBox(height: 10,),
        Container(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: birthdayField,
          ),
        ),
         SizedBox(height: 10,),
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
         SizedBox(height: 10,),
        Column(
          children: [
            maleRadio,
            femaleRadio,
          ],
        ),
         SizedBox(height: 10,),
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
         SizedBox(height: 10,),
         Container(
           height: 40,
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: Row(
               children: [
                 Expanded(child: phoneNumberField),
                 SizedBox(width: 10,),
                 phoneAuthGetButton,
               ],
             ),
           ),
         ),
         SizedBox(height: 10,),
         Container(
           height: 40,
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: Row(
               children: [
                 Expanded(child: phoneAuthField,),
                 SizedBox(width: 10,),
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
                   color: Color.fromRGBO(0, 63, 114, 1),
                 ),
                 Text('공백 특수기호 없이 특수문자만 입력하세요', style: TextStyle(color: Color.fromRGBO(0, 63, 114, 1), fontSize:12), ),
               ],
             ),
           ),
         ),
         SizedBox(height: 10,),
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
         SizedBox(height: 10,),
         Container(
           height: 40,
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: Row(
               children: [
                 Expanded(child: address1Field,),
                 SizedBox(width: 10,),
                 postSearchButton,
               ],
             ),
           ),
         ),
         SizedBox(height: 10,),
         Container(
           height: 40,
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: address1Field,
           ),
         ),
         SizedBox(height: 10,),
         Container(
           height: 40,
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: address3Field,
           ),
         ),
         SizedBox(height: 10,),
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
         SizedBox(height: 10,),
         Container(
           height: 40,
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: carNumber1Field,
           ),
         ),
         SizedBox(height: 10,),
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
         SizedBox(height: 10,),
         Container(
           height: 40,
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: carNumber2Field,
           ),
         ),
         SizedBox(height: 50,),
         registerButton,
         SizedBox(height: 40,),
       ],
    );
  }
}
