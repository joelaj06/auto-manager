import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';

class AddCustomer implements UseCase<Customer, CustomerRequest> {
  AddCustomer({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Customer>> call(CustomerRequest request) {
    return autoManagerRepository.addCustomer(customerRequest: request);
  }
}
