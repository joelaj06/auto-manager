import 'package:automanager/feature/authentication/data/models/request/otp/otp_verification_request.dart';

import '../models/models.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<User> fetchUser(String userId);
  Future<User> updateUser({ required String userId,required UserRequest userRequest});
  Future<MessageResponse> logout();
  Future<UserRegistration> addUser({required UserRequest userRequest});
  Future<MessageResponse> passwordReset( {required PasswordResetRequest resetRequest});
  Future<UserRegistration> verifyOtp({required OtpVerificationRequest request});
}
