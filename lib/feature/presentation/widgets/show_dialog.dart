import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';
import 'package:vacancies/main.dart';

void showOkDialog(
    {required int countPop,
    bool? response,
    required String? title,
    String? content1,
    String? content2}) {
  showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return HorizontalGradientStyle(
          widget: AlertDialog(
            // backgroundColor: Colors.grey.shade800,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            content: (response == true)
                ? Text(content1 ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ))
                : Text(
                    content2 ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 237, 129, 129),
                    ),
                  ),
            actionsPadding: const EdgeInsets.only(bottom: 15),
            actions: [
              Center(
                child: SizedBox(
                  height: 30,
                  width: 100,
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: AppColors.jobColor,
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context)
                          .popUntil((_) => count++ >= countPop);
                      // Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainBackground,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
