import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';

class AutoMangerRemoteDatasourceImpl implements AutoManagerRemoteDatasource {
  AutoMangerRemoteDatasourceImpl({required AppHTTPClient client}) : _client = client;

  final AppHTTPClient _client;

  @override
  Future<Company> addCompany(Company company) async {
    final Map<String, dynamic> json = await _client.post(
        AutoManagerEndpoints.company, body: company.toJson());
    return Company.fromJson(json);
  }

}