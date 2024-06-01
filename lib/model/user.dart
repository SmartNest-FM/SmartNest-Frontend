class UserModel {
  int id;
  final String uid;
  final String nametutor;
  final String nameuser;
  final String emailuser;
  final int age;
  String photouser;

  
  UserModel({
    required this.id,
    required this.uid,
    required this.nametutor,
    required this.nameuser,
    required this.emailuser,
    required this.age,
    required this.photouser,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uId': uid,
      'nameTutor': nametutor,
      'nameUser': nameuser,
      'emailUser': emailuser,
      'age': age,
      'photoUser': photouser,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      uid: map['uId'],
      nametutor: map['nameTutor'],
      nameuser: map['nameUser'],
      emailuser: map['emailUser'],
      age: map['age'],
      photouser: map['photoUser'],
    );
  }



}
