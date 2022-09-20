import 'package:arseli/Data/remote_data_sources/teams/models/TeamSearchModel.dart';
import 'package:arseli/config/dio.dart';
import 'package:dio/dio.dart';

class TeamsRemoteDataSource {
  final ConfiguredDio dio;

  TeamsRemoteDataSource(this.dio);

  CancelToken cancelToken;

  Future<List<TeamBasicDataModel>> search(
      String search, CancelToken cancelToken) async {
    this.cancelToken = cancelToken;
    final result =
        await dio.dio.get('/fetch?term=$search', cancelToken: cancelToken);
    final data = (result.data as List);
    print('remote data search: $search');
    print(data);
    return data.map((e) => TeamBasicDataModel.json(e)).toList();
  }
}
