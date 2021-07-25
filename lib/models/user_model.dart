//User Model
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  final String company;
  final String nickName;
  final String whatToDo;
  final int age;
  final int height;
  final String bodyStyle;
  final String address;
  final String married;
  final String religion;
  final String smoking;
  final String drinking;
  final String greetings;
  late List<dynamic> favoriteListen;
  late List<dynamic> introduceMyself;
  late List<dynamic> favoriteThings;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.photoUrl,
      required this.company,
      required this.nickName,
      required this.whatToDo,
      required this.age,
      required this.height,
      required this.bodyStyle,
      required this.address,
      required this.married,
      required this.religion,
      required this.smoking,
      required this.drinking,
      required this.greetings,
      required this.favoriteListen,
      required this.introduceMyself,
      required this.favoriteThings
      });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      company: data['company'] ?? '',
      nickName: data['nickName'] ?? '',
      whatToDo: data['whatToDo'] ?? '',
      age: data['age'] ?? 0,
      height: data['height'] ?? 150,
      bodyStyle: data['bodyStyle'] ?? '',
      address: data['address'] ?? '',
      married: data['married'] ?? '',
      religion: data['religion'] ?? '',
      smoking: data['smoking'] ?? '',
      drinking: data['drinking'] ?? '',
      greetings: data['greetings'] ?? '',
      favoriteListen: data['favoriteListen'] ?? '',
      introduceMyself: data['introduceMyself'] ?? '',
      favoriteThings: data['favoriteThings'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "photoUrl": photoUrl,
        "company": company,
        "nickName": nickName,
        "whatToDo": whatToDo,
        "age": age,
        "height": height,
        "bodyStyle": bodyStyle,
        "address": address,
        "married": married,
        "religion": religion,
        "smoking": smoking,
        "drinking": drinking,
        "greetings": greetings,
        "favoriteListen": favoriteListen,
        "introduceMyself": introduceMyself,
        "favoriteThings": favoriteThings
      };
}
