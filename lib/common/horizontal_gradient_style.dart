import 'package:flutter/material.dart';
import 'package:vacancies/common/app_colors.dart';

class HorizontalGradientStyle extends StatelessWidget {
  final Widget? widget;
  const HorizontalGradientStyle({this.widget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
            AppColors.mainBackground,
            AppColors.cellBackground,
          ])),
      child: widget,
    );
  }
}
