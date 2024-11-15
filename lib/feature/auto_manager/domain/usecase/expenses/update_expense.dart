import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class UpdateExpense implements UseCase<Expense, UpdateExpenseRequest>{

  UpdateExpense({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Expense>> call(UpdateExpenseRequest request) {
    return autoManagerRepository.updateExpense(updateExpenseRequest: request);
  }
}