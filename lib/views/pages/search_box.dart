import 'package:flutter/material.dart';
import 'package:countries_info/theme/colors.dart';


class SearchBox extends StatelessWidget {

  SearchBox({this.leadingIcon, this.trailingIcon, this.hintText, this.onChangedMethod, this.cancelMethod, this.textBoxController});

  final Icon leadingIcon;
  final Icon trailingIcon;
  final String hintText;
  final Function onChangedMethod;
  final Function cancelMethod;
  final TextEditingController textBoxController;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: leadingIcon,
          title: new TextField(
            controller: textBoxController,
            onChanged: (value){
              onChangedMethod(value);
            },
            decoration: new InputDecoration(
                hintText: hintText, border: InputBorder.none),
          ),
          trailing: FlatButton(
            highlightColor: Colors.white,
            splashColor: AppColors.mainAppColour,
            color: Colors.white,
            onPressed: (){
              cancelMethod();
            } ,
            child: trailingIcon,
          ),
        ),
      ),
    );
  }
}