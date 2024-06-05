class LevelModel {
  int id;
  final String urlImg;
  final String name;
  final int percentage;

  LevelModel({
    required this.id,
    required this.urlImg,
    required this.name,
    required this.percentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'urlImg': urlImg,
      'name': name,
      'percentage': percentage,
    };
  }

  factory LevelModel.fromMap(Map<String, dynamic> map) {
    return LevelModel(
      id: map['id'],
      urlImg: map['urlImg'],
      name: map['name'],
      percentage: map['percentage'],
    );
  }
}
