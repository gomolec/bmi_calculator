import 'dart:math';
import 'package:bmi_calculator/models/models.dart';

class BmiRepository {
  final List<Unit> _measurementUnits = [
    Unit(
      name: "meters",
      type: UnitType.height,
      abbreviation: "m",
      primaryText: "m",
      conversionFunction: (p0, p1) => p0,
    ),
    Unit(
      name: "centimeters",
      type: UnitType.height,
      abbreviation: "cm",
      primaryText: "cm",
      conversionFunction: (p0, p1) => p0 * 0.01,
    ),
    Unit(
      name: "feet and inches",
      type: UnitType.height,
      abbreviation: "ft+in",
      primaryText: "ft",
      secondaryText: "in",
      conversionFunction: (p0, p1) => p0 * 0.3048 + (p1 ?? 0.0) * 0.0254,
    ),
    Unit(
      name: "kilograms",
      type: UnitType.weight,
      abbreviation: "kg",
      primaryText: "kg",
      conversionFunction: (p0, p1) => p0,
    ),
    Unit(
      name: "pounds",
      type: UnitType.weight,
      abbreviation: "lb",
      primaryText: "lb",
      conversionFunction: (p0, p1) => p0 * 0.45359237,
    ),
    Unit(
      name: "stone and pounds",
      type: UnitType.weight,
      abbreviation: "st+lb",
      primaryText: "st",
      secondaryText: "lb",
      conversionFunction: (p0, p1) => p0 * 6.35029 + (p1 ?? 0.0) * 0.45359237,
    ),
  ];

  List<Unit> get measurementUnits => _measurementUnits;

  Unit get defaultHeightUnit => _measurementUnits[1]; // centimeters

  Unit get defaultWeightUnit => _measurementUnits[3]; // kilograms

  Bmi calculateBmi({
    required double height, // in meters
    required double weight, // in kilograms
  }) {
    double bmi = double.parse(
        (weight / pow(height, 2)).toStringAsFixed(2)); // calculate bmi in kg/m3

    return Bmi(
      value: double.parse(bmi.toStringAsFixed(2)),
      type: _getBmiType(bmi),
    );
  }

  BmiType _getBmiType(double bmiResult) {
    if (bmiResult < 16.0) {
      return BmiType.severeThinness;
    }
    if (bmiResult <= 16.9) {
      return BmiType.moderateThinness;
    }
    if (bmiResult <= 18.5) {
      return BmiType.mildThinness;
    }
    if (bmiResult <= 24.9) {
      return BmiType.normal;
    }
    if (bmiResult <= 29.9) {
      return BmiType.overweight;
    }
    if (bmiResult <= 34.9) {
      return BmiType.obeseClassI;
    }
    if (bmiResult <= 39.9) {
      return BmiType.obeseClassII;
    }
    return BmiType.obeseClassIII;
  }
}
