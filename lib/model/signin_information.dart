
class SigninInformation{
  dynamic session = '';
  String accessToken = '';
  String refreshToken = '';
  int userProfileId = 0;
  DateTime lastPasswordUpdateDate;
  bool isTempPassword;
  bool tokenExpired = false;
  bool signState = false;
}