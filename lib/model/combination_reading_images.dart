class CombinationReadingImagesModel {
  int id;
  String question;
  String statement;
  String user_response;
  String correct_answer;
  String answer_one;
  String answer_two;
  String answer_three;
  String main_image;
  String second_image;
  String third_image;
  bool correct;
  int level_id;

  CombinationReadingImagesModel({
    required this.id,
    required this.question,
    required this.statement,
    required this.user_response,
    required this.correct_answer,
    required this.answer_one,
    required this.answer_two,
    required this.answer_three,
    required this.main_image,
    required this.second_image,
    required this.third_image,
    required this.correct,
    required this.level_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'statement': statement,
      'userResponse': user_response,
      'correctAnswer': correct_answer,
      'answerOne': answer_one,
      'answerTwo': answer_two,
      'answerThree': answer_three,
      'mainImage': main_image,
      'secondImage': second_image,
      'thirdImage': third_image,
      'correct': correct,
      'level': {
        'id': level_id,
      },
    };
  }

  factory CombinationReadingImagesModel.fromMap(Map<String, dynamic> map) {
    return CombinationReadingImagesModel(
      id: map['id'],
      question: map['question'],
      statement: map['statement'],
      user_response: map['userResponse'],
      correct_answer: map['correctAnswer'],
      answer_one: map['answerOne'],
      answer_two: map['answerTwo'],
      answer_three: map['answerThree'],
      main_image: map['mainImage'],
      second_image: map['secondImage'],
      third_image: map['thirdImage'],
      correct: map['correct'],
      level_id: map['level']['id'],
    );
  }
  
}