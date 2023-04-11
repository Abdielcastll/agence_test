import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static MyButtonStyles containedPrimaryButtonStyles =
      ContainedPrimaryButtonStyles();
  static MyButtonStyles containedPrimaryStyles = ContainedPrimaryButtonStyles();
  static MyButtonStyles containedSecondaryStyles =
      ContainedSecondaryButtonStyles();

  static MyButtonStyles containedCallToActionStyles =
      ContainedCallToActionButtonStyles();
  static MyButtonStyles outlinedRegularStyles = OutlinedRegularButtonStyles();

  static MyButtonStyles disabledStyles = DisabledButtonStyles();
  static MyButtonStyles getFromVariant(MyButtonVariant variant) {
    switch (variant) {
      case MyButtonVariant.containedPrimary:
        return containedPrimaryButtonStyles;
      case MyButtonVariant.containedSecondary:
        return containedSecondaryStyles;
      case MyButtonVariant.containedCallToAction:
        return containedCallToActionStyles;
      case MyButtonVariant.outlinedRegular:
        return outlinedRegularStyles;
      case MyButtonVariant.disabled:
        return disabledStyles;
    }
  }
}

abstract class MyButtonStyles {
  MyButtonStyles();
  late EdgeInsets inset;
  late TextStyle textStyle;
  late ButtonStyle buttonStyle;
}

class ContainedPrimaryButtonStyles extends MyButtonStyles {
  @override
  EdgeInsets get inset => _padding;
  @override
  TextStyle get textStyle => const TextStyle(color: Colors.white, fontSize: 18);
  @override
  ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: semiRoundedShape,
      );
}

class ContainedSecondaryButtonStyles extends MyButtonStyles {
  @override
  EdgeInsets get inset => _padding;
  @override
  TextStyle get textStyle => const TextStyle(color: Colors.blue, fontSize: 18);
  @override
  ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        shape: semiRoundedShape,
      );
}

class ContainedCallToActionButtonStyles extends MyButtonStyles {
  @override
  EdgeInsets get inset => _padding.copyWith(top: 2, bottom: 2);
  @override
  TextStyle get textStyle => const TextStyle(color: Colors.blue);
  @override
  ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        shape: semiRoundedShape,
      );
}

class OutlinedRegularButtonStyles extends MyButtonStyles {
  @override
  EdgeInsets get inset => _padding;
  @override
  TextStyle get textStyle =>
      const TextStyle(color: Colors.black, fontWeight: FontWeight.w400);
  @override
  ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        shape: semiRoundedShape.copyWith(
          side: BorderSide(color: Colors.blue[200]!),
        ),
      );
}

class DisabledButtonStyles extends MyButtonStyles {
  @override
  EdgeInsets get inset => _padding;
  @override
  TextStyle get textStyle => const TextStyle(color: Colors.white, fontSize: 18);
  @override
  ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        shape: semiRoundedShape,
      );
}

final semiRoundedShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(30));

const _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 7);

enum MyButtonVariant {
  containedPrimary,
  containedSecondary,

  containedCallToAction,
  outlinedRegular,
  disabled
}
