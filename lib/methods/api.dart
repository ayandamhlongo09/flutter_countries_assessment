import 'package:dio/dio.dart';

Future<List> getCountryNames() async {
  final dio = new Dio();

  const String url = 'https://restcountries.eu/rest/v2/region/africa';
  final response = await dio.get(url);
  return response.data;
}