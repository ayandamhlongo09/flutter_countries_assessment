import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGImage extends StatelessWidget {
  SVGImage({@required this.path, @required this.width, @required this.padding});

  final String path;
  final double width;
  final double padding;


  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      path,
      semanticsLabel: 'Country Flag',
      // height: 50,
      width: width,
      fit: BoxFit.contain,

      // fit: BoxFit.contain,
      placeholderBuilder: (BuildContext context) => Container(
          padding: EdgeInsets.all(padding),
          child: const CircularProgressIndicator()),
    );
  }
}
