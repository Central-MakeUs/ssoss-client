import 'package:ssoss_flutter/features/credit/domain/entities/credit_balance.dart';
import 'package:ssoss_flutter/features/credit/domain/repositories/credit_repository.dart';

class GetCreditBalanceUseCase {
  GetCreditBalanceUseCase(this._repository);

  final CreditRepository _repository;

  Future<CreditBalance> call() => _repository.getBalance();
}
