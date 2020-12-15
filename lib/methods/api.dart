import 'package:dio/dio.dart';

getCountryNames() async {
  BaseOptions options = new BaseOptions(
      connectTimeout: 10 * 1000, // 10 seconds
      receiveTimeout: 10 * 1000 // 10 seconds
      );

  final dio = new Dio(options);

  const String url = 'https://restcountries.eu/rest/v2/region/africa';

  try {
    final response = await dio.get(url);
    return response.data;
  } catch (error, stacktrace) {
    print("Exception occurred: $error stackTrace: $stacktrace");
    return "Error: " + error;
  }

  // on DioError catch (ex) {
  //   if (ex.type == DioErrorType.CONNECT_TIMEOUT) {
  //     print("Connection  Timeout Exception");
  //     return "Please check your internet connection and try again";
  //   }
  //   return "Error!";
  // }
}
