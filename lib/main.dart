import 'package:countries_info/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:countries_info/theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(PalotaCountriesAssessmentApp()));
}

class PalotaCountriesAssessmentApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.mainAppColour,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.countries,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
