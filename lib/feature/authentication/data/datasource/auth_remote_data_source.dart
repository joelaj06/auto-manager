import '../models/models.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);

  Future<User> fetchUser(String userId);

  Future<User> updateUser(
      {required String userId, required UserRequest userRequest});

  Future<MessageResponse> logout();

  Future<UserRegistration> addUser({required UserRequest userRequest});

  Future<MessageResponse> passwordReset(
      {required PasswordResetRequest resetRequest});

  Future<UserRegistration> verifyOtp({required OtpVerificationRequest request});

  Future<MessageResponse> verifyPasswordReset({
    required PasswordResetRequest resetRequest,
  });

  Future<User> changePassword({required ChangePasswordRequest request});
}
