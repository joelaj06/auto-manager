import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/data/datasource/automanager_remote_datasource_impl.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'core/utils/utils.dart';
import 'feature/authentication/data/data.dart';
import 'feature/authentication/domain/domain.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    // Ensure http.Client is used explicitly to avoid ambiguity
    Get.lazyPut<http.Client>(() => http.Client());

    Get.put<SharedPreferencesWrapper>(
      SharedPreferencesWrapper(),
    );

    Get.put<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(Get.find()),
    );

    Get.put<AppHTTPClient>(
      AppHTTPClient(authLocalDataSource: Get.find(), httpClient: http.Client()),
    );

    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(client: Get.find()),
    );

    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        authRemoteDataSource: Get.find(),
        authLocalDataSource: Get.find(),
      ),
    );

    Get.put<AutoManagerRemoteDatasource>(
      AutoMangerRemoteDatasourceImpl(
        client: Get.find(),
      ),
    );

    Get.put<AutoManagerRepository>(
      AutoManagerRepositoryImpl(
        autoManagerRemoteDataSource: Get.find(),
      ),
    );
  }
}
