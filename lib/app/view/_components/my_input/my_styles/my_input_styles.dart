import 'package:flutter/material.dart';

InputDecoration get underlinedInputDecoration => InputDecoration(
      helperText: '',
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.red),
      ),
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      // labelStyle: AppTextStyle.labelStyle,
    );
