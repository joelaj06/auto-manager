class AuthEndpoints {
  static const String signin = 'auth/login';
  static const String signOut = 'users/logout';
  static String user(String userId) => 'users/$userId';
  static const String signup = 'users';
  static const String passwordReset = 'users/change-password';
}
