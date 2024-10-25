import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class AuthRepositoryImpl extends Repository implements AuthRepository {
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, User>> login(LoginRequest request) async {
    final Either<Failure, LoginResponse> response =
        await makeRequest(authRemoteDataSource.login(request));

    return response.fold((Failure failure) {
      return left(failure);
    }, (LoginResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      final User user = User(
          id: response.id,
          firstName: response.firstName,
          lastName: response.lastName ?? '',
          email: response.email ?? '',
        );
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> loadUser() async {
    final Either<Failure, LoginResponse> response =
        await makeLocalRequest(authLocalDataSource.getAuthResponse);
    return response.fold((Failure failure) => left(failure),
        (LoginResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      final User user = User(
          id: response.id,
          firstName: response.firstName,
          lastName: response.lastName ?? '',
          email: response.email ?? '',
          );
      return right(user);
    });
  }

  @override
  Future<Either<Failure, User>> fetchUser(String userId) {
    return makeRequest(authRemoteDataSource.fetchUser(userId));
  }

  @override
  Future<Either<Failure, User>> updateUser({
    required String id,
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? phone,
    String? image,
    String? jobTitle,
    String? jobDescription,
    String? company,
    List<String>? skills,
    bool? isAgent,
  }) {
    return makeRequest(
      authRemoteDataSource.updateUser(
        userId: id,
        userRequest: UserRequest(
          firstName: firstName,
          lastName: lastName,
          email: email,
          address: address,
          phone: phone,
          image: image,
          company: company,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, MessageResponse>> logout() async {
    final Either<Failure, MessageResponse> response =
        await makeRequest(authRemoteDataSource.logout());
    return response.fold(
      (Failure failure) => left(failure),
      (MessageResponse response) async {
        await authLocalDataSource.deleteAuthResponse();
        return right(response);
      },
    );
  }

  @override
  Future<Either<Failure, UserRegistration>> addUser({required UserRequest userRequest}) {
    return makeRequest(authRemoteDataSource.addUser(userRequest: userRequest));
  }

  @override
  Future<Either<Failure, MessageResponse>> passwordReset(
      {required PasswordResetRequest resetRequest}) {
    return makeRequest(
        authRemoteDataSource.passwordReset(resetRequest: resetRequest));
  }

  @override
  Future<Either<Failure, UserRegistration>> verifyOtp({required OtpVerificationRequest request}) {
    return makeRequest(authRemoteDataSource.verifyOtp(request: request));
  }
}
