class UserModel {
  final String id;
  final String uid;
  final String nameTutor;
  final String nameUser;
  final String emailUser;
  final int ageUser;
  final String photo;

  UserModel({
    required this.id,
    required this.uid,
    required this.nameTutor,
    required this.nameUser,
    required this.emailUser,
    required this.ageUser,
    required this.photo,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      uid: map['uid'] as String,
      nameTutor: map['nameTutor'] as String,
      nameUser: map['nameUser'] as String,
      emailUser: map['emailUser'] as String,
      ageUser: map['ageUser'] as int,
      photo: map['photo'] as String,
    );
  }

  // Método para convertir una instancia de User a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'nameTutor': nameTutor,
      'nameUser': nameUser,
      'emailUser': emailUser,
      'ageUser': ageUser,
      'photo': photo,
    };
  }
}
