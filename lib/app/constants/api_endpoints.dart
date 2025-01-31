class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";
  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/";

  // ====================== Auth Routes ======================
  static const String login = "users/login";
  static const String register = "users/register";
  static const String getAllUsers = "users/all";
  static const String getUserById = "users/";
  static const String getProfile = "users/profile";
  static const String deleteUser = "users/";
    static const String verifyEmail = "users//verify-otp";
  // static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  // static const String uploadImage = "auth/uploadImage";

  // // ====================== Batch Routes ======================
  // static const String createBatch = "batch/createBatch";
  // static const String getAllBatch = "batch/getAllBatches";
  // static const String deleteBatch = "batch/";

  // // ====================== Course Routes ======================
  // static const String createCourse = "course/createCourse";
  // static const String deleteCourse = "course/";
  // static const String getAllCourse = "course/getAllCourse";
}
