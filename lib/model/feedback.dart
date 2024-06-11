class FeedbackModel {
  int id;
  String feedback;
  String image;
  int feedback_vocabulary_verb_id;
  int feedback_combination_reading_images_id;
  int feedback_fluent_reading_id;
  int feedback_reading_comprehension_id;
  int feedback_phonological_awareness_id;


  FeedbackModel({
    required this.id,
    required this.feedback,
    required this.image,
    required this.feedback_vocabulary_verb_id,
    required this.feedback_combination_reading_images_id,
    required this.feedback_fluent_reading_id,
    required this.feedback_reading_comprehension_id,
    required this.feedback_phonological_awareness_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'feedback': feedback,
      'image': image,
      'vocabularyVerb': {
        'id': feedback_vocabulary_verb_id,
      },
      'combinationReadingImages': {
        'id': feedback_combination_reading_images_id,
      },
      'fluentReading': {
        'id': feedback_fluent_reading_id,
      },
      'readingComprehension': {
        'id': feedback_reading_comprehension_id,
      },
      'phonologicalAwareness': {
        'id': feedback_phonological_awareness_id,
      },
    };
  }


  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      feedback: map['feedback'],
      image: map['image'],
      feedback_vocabulary_verb_id: map['vocabularyVerb']['id'],
      feedback_combination_reading_images_id: map['combinationReadingImages']['id'],
      feedback_fluent_reading_id: map['fluentReading']['id'],
      feedback_reading_comprehension_id: map['readingComprehension']['id'],
      feedback_phonological_awareness_id: map['phonologicalAwareness']['id'],
    );
  }
}