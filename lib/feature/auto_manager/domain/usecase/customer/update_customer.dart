import 'package:automanager/feature/auto_manager/data/model/response/customer/customer.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/request/customer/customer_request.dart';
import '../../repository/automanager_repository.dart';

class UpdateCustomer implements UseCase<Customer, CustomerRequest>{

  UpdateCustomer({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Customer>> call(CustomerRequest request) {
    return autoManagerRepository.updateCustomer(customerRequest: request);
  }
}