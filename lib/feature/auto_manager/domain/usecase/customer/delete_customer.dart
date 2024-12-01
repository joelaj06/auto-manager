import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/data/model/response/customer/customer.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repository/automanager_repository.dart';

class DeleteCustomer implements UseCase<Customer, String> {
  DeleteCustomer({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Customer>> call(String customerId) {
    return autoManagerRepository.deleteCustomer(customerId: customerId);
  }
}
