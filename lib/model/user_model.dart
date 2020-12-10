
class User {
  String username;
  String email;
  String legalName;
  String mobile;
  String address;
  String addressExtended;
  String zipcode;
  String dateofBirth;
  String password;
  String sexCode;
  String vin;
  String vlp;
  String gtoken;
  String ktoken;
  String ntoken;

  User({
    this.address,
    this.addressExtended,
    this.dateofBirth,
    this.email,
    this.gtoken,
    this.ktoken,
    this.legalName,
    this.mobile,
    this.ntoken,
    this.password,
    this.sexCode,
    this.username,
    this.vin,
    this.vlp,
    this.zipcode,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'addressExtended': addressExtended,
      'dateOfBirth': dateofBirth,
      'email': email,
      'gtoken': gtoken,
      'ktoken': ktoken,
      'legalName': legalName,
      'mobile': mobile,
      'ntoken': ntoken,
      'password': password,
      'sexCode': sexCode,
      'username': username,
      'vin': vin,
      'vlp': vlp,
      'zipcode': zipcode,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) => User(
    address: map['address'],
    addressExtended: map['addressExtended'],
    dateofBirth: map['dateOfBirth'],
    email: map['email'],
    gtoken: map['gtoken'],
    ktoken: map['ktoken'],
    legalName: map['legalName'],
    mobile: map['mobile'],
    ntoken: map['ntoken'],
    password: map['password'],
    sexCode: map['sexCode'],
    username: map['username'],
    vin: map['vin'],
    vlp: map['vlp'],
    zipcode: map['zipcode'],
  );

}

