import 'package:flutter/material.dart';
import 'package:test_app/app/view/theme/button_style.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.customInset,
    this.width,
    this.disabled = false,
    this.isLoading = false,
    this.variant = MyButtonVariant.containedPrimary,
  }) : super(key: key);
  final String text;
  final bool disabled;
  final VoidCallback onPressed;
  final EdgeInsets? customInset;
  final bool isLoading;
  final double? width;
  final MyButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    VoidCallback? callback = () {
      if (!isLoading) {
        onPressed();
      }
    };
    var style = AppButtonStyle.getFromVariant(variant);

    if (disabled) {
      callback = null;
      style = AppButtonStyle.getFromVariant(MyButtonVariant.disabled);
    }

    return TextButton(
      onPressed: callback,
      style: style.buttonStyle,
      child: Padding(
        padding: customInset ?? style.inset,
        child: SizedBox(
          width: width,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isLoading
                ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: style.textStyle.color ?? Colors.blue,
                    ),
                  )
                : Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.merge(style.textStyle),
                  ),
          ),
        ),
      ),
    );
  }
}
