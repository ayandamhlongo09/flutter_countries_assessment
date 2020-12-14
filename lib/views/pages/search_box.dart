import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            decoration: new InputDecoration(
                hintText: 'Search Countries', border: InputBorder.none),
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
          ),
        ),
      ),
    );
  }
}
