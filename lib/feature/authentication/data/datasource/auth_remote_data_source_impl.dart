

import '../../../../core/utils/app_http_client.dart';
import '../models/models.dart';
import 'auth_endpoints.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required AppHTTPClient client})
      : _client = client;
  final AppHTTPClient _client;


  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.signin,
      body: request.toJson(),
    );
    return LoginResponse.fromJson(json);
  }

  @override
  Future<User> fetchUser(String userId) async {
    final Map<String, dynamic> json =
        await _client.get(AuthEndpoints.user(userId));
    return User.fromJson(json);
  }

  @override
  Future<User> updateUser(
      {required String userId, required UserRequest userRequest}) async {
    final Map<String, dynamic> json = await _client
        .put(AuthEndpoints.user(userId), body: userRequest.toJson());
    return User.fromJson(json);
  }

  @override
  Future<MessageResponse> logout() async {
    return const MessageResponse(message: 'Logout successful');
  }

  @override
  Future<UserRegistration> addUser({required UserRequest userRequest}) async {
    final Map<String, dynamic> json =
        await _client.post(AuthEndpoints.signup, body: userRequest.toJson());
    return UserRegistration.fromJson(json);
  }

  @override
  Future<MessageResponse> passwordReset(
      {required PasswordResetRequest resetRequest}) async {
    final Map<String, dynamic> json = await _client
        .post(AuthEndpoints.passwordReset, body: resetRequest.toJson());
    return MessageResponse.fromJson(json);
  }

  @override
  Future<UserRegistration> verifyOtp({required OtpVerificationRequest request}) async{
    final Map<String, dynamic> json = await _client
        .post(AuthEndpoints.verifyOtp, body: request.toJson());
    return UserRegistration.fromJson(json);
  }

  @override
  Future<MessageResponse> verifyPasswordReset({required PasswordResetRequest resetRequest}) async {
    final Map<String, dynamic> json = await _client
        .put(AuthEndpoints.verifyPasswordReset, body: resetRequest.toJson());
    return MessageResponse.fromJson(json);
  }

  @override
  Future<User> changePassword({required ChangePasswordRequest request}) async{
     await _client
        .put(AuthEndpoints.changePassword, body: request.toJson());
    return User.empty();
  }
}
