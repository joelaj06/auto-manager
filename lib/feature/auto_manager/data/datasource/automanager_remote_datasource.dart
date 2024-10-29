import '../model/model.dart';

abstract class AutoManagerRemoteDatasource{
  Future<Company> addCompany(Company company);
}