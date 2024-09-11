class User {
  int? id;
  String? name;
  String? age;
  String? phonenumber;
  String? email;
  String? gender;

  usermap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['age'] = age!;
    mapping['phonenumber'] = phonenumber!;
    mapping['email'] = email!;
    mapping['gender'] = gender!;
    return mapping;
  }
}
