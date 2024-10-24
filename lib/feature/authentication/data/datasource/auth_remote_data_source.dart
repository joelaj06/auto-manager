import '../models/models.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<User> fetchUser(String userId);
  Future<User> updateUser({ required String userId,required UserRequest userRequest});
  Future<MessageResponse> logout();
  Future<User> addUser({required UserRequest userRequest});
  Future<MessageResponse> passwordReset( {required PasswordResetRequest resetRequest});
}
