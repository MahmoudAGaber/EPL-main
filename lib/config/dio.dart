import 'package:arseli/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ConfiguredDio {
  Dio dio;
  CancelToken cancelToken = CancelToken();

  ConfiguredDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: ConfigConstants.defaultHost,
      ),
    );

    dio.interceptors.add(PrettyDioLogger());
  }
}
