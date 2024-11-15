import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class DeleteExpense implements UseCase<Expense, String>{
  DeleteExpense({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Expense>> call(String expenseId) {
    return autoManagerRepository.deleteExpense(expenseId: expenseId);
  }

}