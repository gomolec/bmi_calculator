import 'package:flutter/widgets.dart';

enum BmiType {
  severeThinness("wygłodzenie", Color(0xFF0080BD), "< 16,0"),
  moderateThinness("wychudzenie", Color(0xFF00A383), "16,0 - 16,9"),
  mildThinness("niedowaga", Color(0xFF00C199), "17,0 - 18,5"),
  normal("waga prawidłowa", Color(0xFF01D066), "18,5 - 24,9"),
  overweight("nadwaga", Color(0xFFF9C500), "25,0 - 29,9"),
  obeseClassI("otyłość I stopnia", Color(0xFFFF9901), "30,0 - 34,9"),
  obeseClassII("otyłość II stopnia", Color(0xFFF47800), "35,0 - 39,9"),
  obeseClassIII("otyłość III stopnia", Color(0xFFE34900), "≥ 40");

  final String text;
  final Color color;
  final String range;
  const BmiType(this.text, this.color, this.range);
}
