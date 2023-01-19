import 'dart:math';

import 'models/models.dart';

class CalculatorRepository {
  double calculate({
    required double height,
    required double weight,
  }) {
    double bmi = weight / pow(height, 2);
    return double.parse(bmi.toStringAsFixed(2));
  }

  BmiType getBmiType(double bmiResult) {
    if (bmiResult < 16.0) {
      return BmiType.severeThinness;
    } else if (bmiResult <= 16.9) {
      return BmiType.moderateThinness;
    } else if (bmiResult <= 18.5) {
      return BmiType.mildThinness;
    } else if (bmiResult <= 24.9) {
      return BmiType.normal;
    } else if (bmiResult <= 29.9) {
      return BmiType.overweight;
    } else if (bmiResult <= 34.9) {
      return BmiType.obeseClassI;
    } else if (bmiResult <= 39.9) {
      return BmiType.obeseClassII;
    }
    return BmiType.obeseClassIII;
  }

  double centimetersToMeters({
    required double centimeters,
  }) {
    return centimeters * 0.01;
  }

  double feetAndInchesToMeters({
    required double feets,
    required double inches,
  }) {
    return (feets * 0.3048 + inches * 0.0254);
  }

  double poundsToKilograms({
    required double pounds,
  }) {
    return pounds * 0.45359237;
  }
}
