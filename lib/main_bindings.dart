import 'package:get/get.dart';

import 'core/utils/utils.dart';
import 'feature/authentication/data/data.dart';
import 'feature/authentication/domain/domain.dart';
class MainBindings extends Bindings {
  @override
  void dependencies() {


    Get.put<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(Get.find()),
    );


    Get.put<AppHTTPClient>(
      AppHTTPClient(Get.find()),
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


  }
}