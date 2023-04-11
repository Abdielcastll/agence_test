import 'dart:math' as math;

import 'package:flutter/material.dart';

class NoScaleTextWidget extends StatelessWidget {
  final Widget child;

  const NoScaleTextWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaxScaleTextWidget(
      max: 0.82,
      child: child,
    );
  }
}

class MaxScaleTextWidget extends StatelessWidget {
  final double max;
  final Widget child;

  const MaxScaleTextWidget({
    Key? key,
    this.max = 1,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    var scale = math.min(max, data.textScaleFactor);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: scale),
      child: child,
    );
  }
}
