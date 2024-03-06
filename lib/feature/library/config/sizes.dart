import 'package:flutter/material.dart';

class SizesConfig {
  SizesConfig(
    this.context,
  );

  final BuildContext context;

  double get clothingCardHeight => MediaQuery.of(context).size.height * 1;
  // double get clothingCardHeight => MediaQuery.of(context).size.height * 0.74;

  // double get clothingCardWidth => MediaQuery.of(context).size.height * 0.9;
  double get clothingCardWidth => MediaQuery.of(context).size.height * 1;
}
