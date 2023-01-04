class UserModelFireBase {
  UserModelFireBase({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.id,
  });
  late final String id;
  late final String name;
  late final String email;
  late final String phone;
  late final String password;
  late final String uid;

  UserModelFireBase.fromJson(Map<String, dynamic> json, String id) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    id = json['id'] ?? "";
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['password'] = password;
    _data['uid'] = uid;
    return _data;
  }
}
