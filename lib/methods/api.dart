import 'package:dio/dio.dart';

getCountryNames() async {
  BaseOptions options = new BaseOptions(
      connectTimeout: 10 * 1000, // 10 seconds
      receiveTimeout: 10 * 1000 // 10 seconds
  );

  final dio = new Dio(options);

  String url = 'https://restcountries.eu/rest/v2/region/africa';

  try {
    final response = await dio.get(url);
    return response.data;
  } catch (error, stacktrace) {
    print("Exception occurred: $error stackTrace: $stacktrace");
    return "Error: " + error;
  }
}

getCountryDetail( String countryCode)async{
  BaseOptions options = new BaseOptions(
      connectTimeout: 10 * 1000, // 10 seconds
      receiveTimeout: 10 * 1000 // 10 seconds
  );

  final dio = new Dio(options);

   String url = 'https://restcountries.eu/rest/v2/alpha/' + countryCode;

  try {
    final response = await dio.get(url);
    return response.data;
  } catch (error, stacktrace) {
    print("Exception occurred: $error stackTrace: $stacktrace");
    return "Error: " + error;
  }
}
