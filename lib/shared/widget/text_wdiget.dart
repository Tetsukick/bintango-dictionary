import 'package:auto_size_text/auto_size_text.dart';
import 'package:bintango_indonesian_dictionary/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';

class TextWidget {
  static Widget titleRedMedium(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 11,
        maxFontSize: 16,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.primaryRed900,
            fontSize: 14,
        ),
      ),
    );
  }

  static Widget titleRedMediumNotSelectable(String data, {int maxLines = 1}) {
    return AutoSizeText(
      data,
      maxLines: maxLines,
      minFontSize: 11,
      maxFontSize: 16,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorConstants.primaryRed900,
        fontSize: 14,
      ),
    );
  }

  static Widget titleRedLargestBold(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 24,
        maxFontSize: 32,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.primaryRed900,
            fontSize: 32,
        ),
      ),
    );
  }

  static Widget titleBlackLargeBold(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 16,
        maxFontSize: 24,
        style: titleBlackLargeBoldStyle,
      ),
    );
  }

  static TextStyle titleBlackLargeBoldStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    color: ColorConstants.fontBlack,
    fontSize: 24,
  );

  static Widget titleBlackLargestBold(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 20,
        maxFontSize: 28,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.fontBlack,
            fontSize: 28,
        ),
      ),
    );
  }

  static Widget titleBlackLargestBoldNotSelectable(String data, {int maxLines = 1}) {
    return AutoSizeText(
      data,
      maxLines: maxLines,
      minFontSize: 20,
      maxFontSize: 28,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorConstants.fontBlack,
          fontSize: 28,
      ),
    );
  }

  static Widget titleBlackMediumBold(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 14,
        maxFontSize: 18,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.fontBlack,
            fontSize: 18,
        ),
      ),
    );
  }

  static Widget titleBlackSmallBold(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 9,
        maxFontSize: 14,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.fontBlack,
            fontSize: 12,
        ),
      ),
    );
  }

  static Widget titleGrayLargeBold(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 16,
        maxFontSize: 20,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.fontGrey,
            fontSize: 20,
        ),
      ),
    );
  }

  static Widget titleGrayMediumBold(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 14,
        maxFontSize: 20,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.fontGrey,
            fontSize: 20,
        ),
      ),
    );
  }

  static Widget titleGrayMedium(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 14,
        maxFontSize: 18,
        style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: ColorConstants.fontGrey,
            fontSize: 18,
        ),
      ),
    );
  }

  static Widget titleGrayMediumSmallBold(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 14,
        maxFontSize: 18,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.fontGrey,
            fontSize: 18,
        ),
      ),
    );
  }

  static Widget titleGrayMediumSmallBoldNotSelectable(String data, {int maxLines = 1}) {
    return AutoSizeText(
      data,
      maxLines: maxLines,
      minFontSize: 14,
      maxFontSize: 18,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorConstants.fontGrey,
        fontSize: 18,
      ),
    );
  }

  static Widget titleGraySmallBold(String data, {
    int maxLines = 1,
    TextAlign textAlign = TextAlign.center,

  }) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 11,
        maxFontSize: 16,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.fontGrey,
            fontSize: 14,
        ),
      ),
    );
  }
  static Widget titleGraySmallBoldNotSelectable(String data, {
    int maxLines = 1,
    TextAlign textAlign = TextAlign.center,

  }) {
    return AutoSizeText(
      data,
      maxLines: maxLines,
      minFontSize: 11,
      maxFontSize: 16,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorConstants.fontGrey,
          fontSize: 14,
      ),
    );
  }

  static Widget titleGraySmallest(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 9,
        maxFontSize: 12,
        style: const TextStyle(
            color: ColorConstants.fontGrey,
            fontSize: 12,
        ),
      ),
    );
  }

  static Widget titleGraySmall(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 9,
        maxFontSize: 16,
        style: const TextStyle(
            color: ColorConstants.fontGrey,
            fontSize: 14,
        ),
      ),
    );
  }

  static Widget titleBlueSmallNotSelectable(String data, {int maxLines = 1}) {
    return AutoSizeText(
      data,
      maxLines: maxLines,
      minFontSize: 9,
      maxFontSize: 16,
      style: const TextStyle(
        color: Colors.blueAccent,
        fontSize: 14,
      ),
    );
  }

  static Widget titleWhiteLargeBold(String data, {int maxLines = 1}) {
    return SelectionArea(
      child: AutoSizeText(
        data,
        maxLines: maxLines,
        minFontSize: 16,
        maxFontSize: 28,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.fontWhite,
            fontSize: 24,
        ),
      ),
    );
  }

  static Widget titleWhiteSmallBoldWithBackGround(String data, {int maxLines = 1}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorConstants.primaryRed900,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: SelectionArea(
          child: AutoSizeText(
            data,
            maxLines: maxLines,
            maxFontSize: 16,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorConstants.fontWhite,
                fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
