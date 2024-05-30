import 'package:bintango_indonesian_dictionary/shared/route/app_router.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/text_wdiget.dart';
import 'package:flutter/material.dart';

void snackbarSuccess(
    String message, {
      String? label,
      void Function()? onPressed,
    }) {
  final snackBar = SnackBar(
    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
    width: 450,
    content: Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
          const SizedBox(width: 8,),
          Flexible(child: TextWidget.titleGrayMediumSmallBold(message, maxLines: 3)),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    onVisible: () {},
    elevation: 4,
    backgroundColor: Colors.white,
    closeIconColor: Colors.green,
    dismissDirection: DismissDirection.horizontal,
  );
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
}

void snackbarError(
    String message, {
      String? label,
      void Function()? onPressed,
    }) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Expanded(
          child: Text(message),
        ),
        if (label != null)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green,
              side: const BorderSide(
                color: Colors.green,
              ),
            ),
            onPressed: onPressed,
            child: Text(label),
          ),
      ],
    ),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
}
