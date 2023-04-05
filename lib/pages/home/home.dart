import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AAColors.backgroundGrayView,
      child: Center(
        child: Text("HOME"),
      ),
    );
  }
}
