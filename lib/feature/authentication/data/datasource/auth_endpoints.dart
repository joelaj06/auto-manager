class AuthEndpoints {
  static const String signin = 'auth/login';
  static const String signOut = 'users/logout';
  static String user(String userId) => 'users/$userId';
  static const String signup = 'auth/register';
  static const String passwordReset = 'users/change-password';
  static const String verifyOtp = 'auth/verifyOtp';

}
