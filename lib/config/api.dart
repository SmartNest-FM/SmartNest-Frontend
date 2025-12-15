class Api {
  static const String baseUrl = "http://192.168.100.26:8080";

   // ===== LEVEL =====
  static String getLevel(int id) =>
      "$baseUrl/level/$id";

  static String getAllLevels() =>
      "$baseUrl/level";

  static String createLevel() =>
      "$baseUrl/level";

  static String updateLevel(int id) =>
      "$baseUrl/level/$id";

  static String deleteLevel(int id) =>
      "$baseUrl/level/$id";

  // ===== ACTIVIDADES =====
  static String phonologicalById(int id) =>
      "$baseUrl/phonologicalAwareness/$id";

  static String readingById(int id) =>
      "$baseUrl/readingComprehension/$id";

  static String vocabularyById(int id) =>
      "$baseUrl/vocabularyVerb/$id";

  static String fluentById(int id) =>
      "$baseUrl/fluentReading/$id";

  static String combinationById(int id) =>
      "$baseUrl/combinationReadingImages/$id";

  // ===== PROGRESO =====
  static String savePhonologicalProgress(int activityId) =>
      "$baseUrl/progress/phonological/$activityId";

  static String saveReadingProgress(int activityId) =>
      "$baseUrl/progress/reading/$activityId";

  static String saveVocabularyProgress(int activityId) =>
      "$baseUrl/progress/vocabulary/$activityId";

  static String saveFluentProgress(int activityId) =>
      "$baseUrl/progress/fluent/$activityId";

  static String saveCombinationProgress(int activityId) =>
      "$baseUrl/progress/combination/$activityId";

  static String progressPercentage(int levelId) =>
      "$baseUrl/progress/percentage/$levelId";

  static String progressLevels(String uid) =>
      "$baseUrl/progress/levels?uid=$uid";

  static String activityStatus(String type, int activityId, String uid) =>
      "$baseUrl/progress/status/$type/$activityId?uid=$uid";
      
  // ===== USUARIO =====
  static String getUserById(int id) =>
      "$baseUrl/user/$id";

  static String getAllUsers() =>
      "$baseUrl/user";

  static String createUser() =>
      "$baseUrl/user";

  static String updateUser(int id) =>
      "$baseUrl/user/$id";

  static String deleteUser(int id) =>
      "$baseUrl/user/$id";

  static String userByUid(String uid) =>
      "$baseUrl/user/by-uid/$uid";

    // ===== FEEDBACK (phonological) =====
  static String phonologicalFeedback(int activityId) =>
      "$baseUrl/phonological/$activityId";

    // ===== FEEDBACK (fluent) =====
  static String fluentFeedback(int id) => "$baseUrl/fluent/$id";

   // ===== FEEDBACK (reading_comprehension) =====
  static String readingFeedback(int id) => "$baseUrl/reading/$id";

   // ===== FEEDBACK (combinationReadingImages) =====
  static String combinationFeedback(int id) => "$baseUrl/combination/$id";

  // ===== FEEDBACK (vocabularyVerb) =====
  static String vocabularyFeedback(int id) => "$baseUrl/vocabulary/$id";

}
