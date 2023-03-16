import 'package:flutter/material.dart';
import 'package:vacancies/common/app_colors.dart';

class VerticalGradientStyle extends StatelessWidget {
  final Widget? widget;
  const VerticalGradientStyle({this.widget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          // tileMode: TileMode.repeated,
          stops: [0.1, 0.9],
          colors: <Color>[
            AppColors.mainBackground,
            Color.fromARGB(255, 111, 111, 111),
          ],
        ),
      ),
      child: widget,
    );
  }
}
