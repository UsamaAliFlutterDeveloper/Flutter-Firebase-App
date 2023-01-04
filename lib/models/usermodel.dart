class UserModel {
  UserModel({
    required this.city,
    required this.cnic,
    required this.fathername,
    required this.phoneno,
    required this.username,
  });
  late final String city;
  late final String cnic;
  late final String fathername;
  late final String phoneno;
  late final String username;
  
  UserModel.fromJson(Map<String, dynamic> json){
    city = json['city'];
    cnic = json['cnic'];
    fathername = json['fathername'];
    phoneno = json['phoneno'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['city'] = city;
    _data['cnic'] = cnic;
    _data['fathername'] = fathername;
    _data['phoneno'] = phoneno;
    _data['username'] = username;
    return _data;
  }
}
