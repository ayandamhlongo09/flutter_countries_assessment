import 'package:countries_info/components/svgImage.dart';
import 'package:countries_info/methods/api.dart';
import 'package:countries_info/routes.dart';
import 'package:countries_info/views/pages/countryDetail.dart';
import 'package:countries_info/views/pages/search_box.dart';
import 'package:flutter/material.dart';

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {

  Future<List> countries;

  @override
  void initState() {
    countries =
    Future<List>.delayed(Duration(seconds: 2), () => getCountryNames());
    super.initState();
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
            child: FutureBuilder<List>(
              future: countries,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: EdgeInsets.only(top:70),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.only(right: 15, bottom: 10),
                                child:
                                SVGImage(path:snapshot.data[index]['flag'], width: 60, padding: 12.0,),
                              ),
                            ),
                            Positioned(
                                top: 25,
                                left: 25,
                                child: Container(
                                  height: 20,
                                  child: Material(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: MaterialButton(
                                      minWidth: 20,
                                      child: Text(
                                        snapshot.data[index]['alpha2Code'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        title: Text(snapshot.data[index]['name']),
                        subtitle: Text(snapshot.data[index]['capital']),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CountryDetailPage(
                                country: snapshot.data[index]),
                          ));
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        indent: 90,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 100,
                      height: 100,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text(
                        'Getting Countries...',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ),
          SearchBox()
        ],
      ),
    );
  }
}
