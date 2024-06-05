class FluentReadingModel {
  int id;
  String? main_image;
  String? question;
  String? statement;
  String user_response;
  String correct_answer;
  String answer_one;
  String answer_two;
  String answer_three;
  bool correct;
  int level_id;

  FluentReadingModel({
    required this.id,
    required this.main_image,
    required this.question,
    required this.statement,
    required this.user_response,
    required this.correct_answer,
    required this.answer_one,
    required this.answer_two,
    required this.answer_three,
    required this.correct,
    required this.level_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mainImage': main_image,
      'question': question,
      'statement': statement,
      'userResponse': user_response,
      'correctAnswer': correct_answer,
      'answerOne': answer_one,
      'answerTwo': answer_two,
      'answerThree': answer_three,
      'correct': correct,
      'level': {
        'id': level_id,
      },
    };
  }

  factory FluentReadingModel.fromMap(Map<String, dynamic> map) {
    return FluentReadingModel(
      id: map['id'],
      main_image: map['mainImage'],
      question: map['question'],
      statement: map['statement'],
      user_response: map['userResponse'],
      correct_answer: map['correctAnswer'],
      answer_one: map['answerOne'],
      answer_two: map['answerTwo'],
      answer_three: map['answerThree'],
      correct: map['correct'],
      level_id: map['level']['id'],
    );
  }
}
