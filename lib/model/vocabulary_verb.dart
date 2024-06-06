class VocabularyVerbModel {

  int id;
  String main_image;
  String question;
  String statement;
  String user_response;
  String correct_answer;
  bool correct;
  String word_select_verb;
  String answer_one;
  String answer_two;
  String answer_three;
  int level_id;
  String verb_synonym_one;
  String verb_synonym_two;
  String verb_synonym_three;
  String verb_synonym_four;

  VocabularyVerbModel({
    required this.id,
    required this.main_image,
    required this.question,
    required this.statement,
    required this.user_response,
    required this.correct_answer,
    required this.correct,
    required this.word_select_verb,
    required this.answer_one,
    required this.answer_two,
    required this.answer_three,
    required this.level_id,
    required this.verb_synonym_one,
    required this.verb_synonym_two,
    required this.verb_synonym_three,
    required this.verb_synonym_four,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mainImage': main_image,
      'question': question,
      'statement': statement,
      'userResponse': user_response,
      'correctAnswer': correct_answer,
      'correct': correct,
      'wordSelectVerb': word_select_verb,
      'answerOne': answer_one,
      'answerTwo': answer_two,
      'answerThree': answer_three,
      'level': {
        'id': level_id,
      },
      'verbSynonymOne': verb_synonym_one,
      'verbSynonymTwo': verb_synonym_two,
      'verbSynonymThree': verb_synonym_three,
      'verbSynonymFour': verb_synonym_four,
    };
  }

  factory VocabularyVerbModel.fromMap(Map<String, dynamic> map) {
    return VocabularyVerbModel(
      id: map['id'],
      main_image: map['mainImage'],
      question: map['question'],
      statement: map['statement'],
      user_response: map['userResponse'],
      correct_answer: map['correctAnswer'],
      correct: map['correct'],
      word_select_verb: map['wordSelectVerb'],
      answer_one: map['answerOne'],
      answer_two: map['answerTwo'],
      answer_three: map['answerThree'],
      level_id: map['level']['id'],
      verb_synonym_one: map['verbSynonymOne'],
      verb_synonym_two: map['verbSynonymTwo'],
      verb_synonym_three: map['verbSynonymThree'],
      verb_synonym_four: map['verbSynonymFour'],
    );
  }
}
