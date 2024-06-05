import 'package:smartnest/model/level.dart';

class PhonologicalAwarenessModel {
  int id;
  String? main_image;
  String? question;
  String user_response;
  String correct_answer;
  bool is_correct;
  int level_id; 
  String answer_one;
  String answer_two;
  String answer_three;

  PhonologicalAwarenessModel({
    required this.id,
    required this.main_image,
    required this.question,
    required this.user_response,
    required this.correct_answer,
    required this.is_correct,
    required this.level_id,
    required this.answer_one,
    required this.answer_two,
    required this.answer_three
  });


  factory PhonologicalAwarenessModel.fromMap(Map<String, dynamic> map) {
    return PhonologicalAwarenessModel(
      id: map['id'],
      main_image: map['mainImage'],
      question: map['question'],
      user_response: map['userResponse'],
      correct_answer: map['correctAnswer'],
      is_correct: map['correct'],
      level_id: map['level']['id'],
      answer_one: map['answerOne'],
      answer_two: map['answerTwo'],
      answer_three: map['answerThree']
    );
  }


   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'main_image': main_image,
      'question': question,
      'user_response': user_response,
      'correct_answer': correct_answer,
      'is_correct': is_correct,
      'level_id': level_id,
      'answer_one': answer_one,
      'answer_two': answer_two,
      'answer_three': answer_three
    };
  }

}
