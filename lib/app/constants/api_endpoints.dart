class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api/";
  // static const String baseUrl = "http://192.168.1.76:3000/api/";
  static const String baseUrl = "http://192.168.101.7:3000/api/";

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
  static const String getuser = "users/";

  // ====================== Guidance Routes ======================
  static const String createGuidance = "guidances/post";
  static const String getAllGuidances = "guidances/getall";
  static const String getGuidanceById = "guidances/";
  static const String updateGuidance = "guidances/";
  static const String updateDocumentTracking = "guidances/";
}
