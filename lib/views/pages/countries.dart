import 'package:countries_info/components/svgImage.dart';
import 'package:countries_info/methods/api.dart';
import 'package:countries_info/routes.dart';
import 'package:countries_info/views/pages/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:countries_info/theme/colors.dart';


class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {

  List countries = [];
  List filteredCountries = [];
  bool errorLoadingCountries = false;
  String errorMessage= "";

  TextEditingController _searchBoxController = new TextEditingController();

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    loadScreen();
    super.initState();
  }
  void loadScreen(){
    getCountryNames().then((data){
      if (data.toString().startsWith("Error")){
        countries = filteredCountries = [];
        errorMessage= data;
        errorLoadingCountries = true;
      }
      else{
        setState(() {
          countries = filteredCountries = data;
        });
      }

    });
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void _filterCountries(value){
    setState(() {
      filteredCountries = countries
          .where((country) =>
          country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _cancelSearch(){
    setState(() {
      filteredCountries = countries;
      _searchBoxController.text= "";
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("African Countries"),
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.about)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: filteredCountries.length > 0 ? ListView.separated(
              padding: EdgeInsets.only(top:70),
              itemCount: filteredCountries.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.only(right: 15, bottom: 10),
                          child:
                          SVGImage(path: filteredCountries[index]['flag'], width: 60, padding: 12.0,),
                        ),
                      ),
                      Positioned(
                          top: 25,
                          left: 25,
                          child: Container(
                            height: 20,
                            child: Material(
                              color: AppColors.mainAppColour,
                              borderRadius: BorderRadius.circular(8.0),
                              child: MaterialButton(
                                minWidth: 20,
                                child: Text(
                                  filteredCountries[index]['alpha2Code'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  title: Text(filteredCountries[index]['name']),
                  subtitle: Text(filteredCountries[index]['capital']),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.countryDetail,
                      arguments: filteredCountries[index]);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 90,
                );
              },
            ):
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  errorLoadingCountries? SizedBox(
                    child: Column(
                      children: [
                        Text('Oops!', style: TextStyle(fontSize: 70, color: Colors.grey),),
                        Text(errorMessage, style: TextStyle(fontSize: 40, color: Colors.grey),),
                      ],
                    ),
                  )
                      :
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 100,
                    height: 100,
                  ),
                  errorLoadingCountries?
                      FlatButton(onPressed: loadScreen, textColor: Colors.white, color: AppColors.mainAppColour, child: Text('Retry'),)

                      :const Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      'Getting Countries...',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                ],
              ),
            )



           ,
          ),

          SearchBox(leadingIcon: Icon(Icons.search), trailingIcon: Icon(Icons.cancel,color: Colors.grey,), hintText: "Search Countries" , onChangedMethod:_filterCountries, cancelMethod: _cancelSearch, textBoxController: _searchBoxController,)

        ],
      ),
    );
  }
}
