import 'package:flutter/widgets.dart';

class Logo extends StatelessWidget {
  final double width;
  final double height;
  const Logo({this.width = 120, this.height = 120, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/img/logo.png',
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
