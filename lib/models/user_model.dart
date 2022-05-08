class UserModel {
  late String name;
  late String lastname;
  late String phone;
  late String eMail;
  late String uId;
  late List relatives;
  UserModel({
    required this.name,
    required this.phone,
    required this.eMail,
    required this.uId,
    required this.lastname,
    required this.relatives,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    relatives = json['relatives'];
    eMail = json['eMail'];
    uId = json['uId'];
    lastname = json['lastname'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'relatives': relatives,
      'phone': phone,
      'eMail': eMail,
      'uId': uId,
      'lastname': lastname,
    };
  }
}
