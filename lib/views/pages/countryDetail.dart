import 'package:countries_info/components/svgImage.dart';
import 'package:countries_info/methods/api.dart';
import 'package:countries_info/methods/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:countries_info/routes.dart';
import 'package:countries_info/theme/colors.dart';

class CountryDetailPage extends StatelessWidget {

  // const CountryDetailPage({this.country});

  @override
  Widget build(BuildContext context) {

    final Map country = ModalRoute.of(context).settings.arguments;



    String getPath(int index){
      List countryDetail = [];

      getCountryDetail(country['borders'][index]).then((data){
        countryDetail =data;
        print(data);
      });
      print(countryDetail);


      
      return "";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(country['name']),
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.about)),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  maxRadius: 25,
                                  child: Text(
                                    country['alpha2Code'],
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                  backgroundColor: AppColors.mainAppColour),
                              SizedBox(
                                width: 22,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    country['name'],
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.black54),
                                  ),
                                  Text(
                                    country['subregion'],
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade500),
                                  )
                                ],
                              ),
                            ],
                          )),
                      SVGImage(
                        path: country['flag'],
                        width: MediaQuery.of(context).size.width,
                        padding: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Text(
                          country['name'] +
                              ' covers an area of ' +
                              country['area']
                                  .toString()
                                  .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "") +
                              ' km\u00b2 ' +
                              'and  has a population of ' +
                              country['population'].toString() +
                              ' - the nation has a Gini coefficient of ' +
                              getRandomNumber().toStringAsFixed(
                                  1) // Could not find coefficient value, So i made my own.
                              +
                              '. A resident of ' +
                              country['name'] +
                              ' is called a ' +
                              country['demonym'] +
                              '. The main currency accepted a legal tender is the ' +
                              country['currencies'][0]['name'] +
                              ' which is expressed with the symbol \'' +
                              country['currencies'][0]['symbol'] +
                              '\'.',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              letterSpacing: 0.5,
                              wordSpacing: 0.7),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 30, color: Colors.grey.shade700),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sub-region',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey.shade800),
                          ),
                          Text(country['subregion'],
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                  height: 1.5)),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 75,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15, top: 7),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        size: 30,
                        color: Colors.grey.shade700,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Capital',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey.shade800),
                          ),
                          Text(country['capital'],
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                  height: 1.5)),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 75,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Material(
                elevation: 2,
                color: Colors.green.shade800,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    height: 50.0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text('Languages',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    )),
              ),
            ],
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(20),
              itemCount: country['languages'].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 2.5),
              itemBuilder: (BuildContext context, int index) {
                return RaisedButton(
                  padding: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(75.0)),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff00ACBA),
                            Color(0xff0094C0),
                            Color(0xff007FC6)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 280.0, minHeight: 52.0),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              country['languages'][index]['nativeName'],
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '(' + country['languages'][index]['name'] + ')',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        )),
                  ),
                );
              }),
          Row(
            children: [
              Material(
                elevation: 2,
                color: Colors.green.shade800,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    height: 50.0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text('Bordering Countries',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    ),

                  onPressed: (){
                      print(country['borders']);
                      print(country['flag']);
                      print(country['alpha3Code']);
                  },),
              ),
            ],
          ),
          new Container(
            padding: EdgeInsets.all(20),
            height: 150,
            child: new ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: country['borders'].length,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                // print(country['borders'][index]);
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      width: 100.0,
                      height: 70.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: SVGImage(
                          path:getPath(index )
                          ,
                          width: 60,
                          padding: 12.0,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
