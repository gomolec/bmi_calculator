import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/calculator_repository.dart';

void main() {
  late CalculatorRepository sut;

  setUp(() {
    sut = CalculatorRepository();
  });

  group(
    "unit conversion",
    () {
      test('conversion centimeters to meters', () {
        final height = sut.centimetersToMeters(centimeters: 100);

        expect(height, 1);
      });

      test('conversion feets and inches to meters', () {
        final height = sut.feetAndInchesToMeters(
          feets: 5,
          inches: 10,
        );

        expect(height, 1.778);
      });

      test('conversion pounds to kilograms', () {
        final weight = sut.poundsToKilograms(pounds: 50);

        expect(weight, 22.6796185);
      });
    },
  );

  group(
    "BMI calculation",
    () {
      test('calculating with meters and kilograms', () {
        final bmi = sut.calculate(
          height: 1.8,
          weight: 60,
        );

        expect(bmi, 18.52);
      });
    },
  );
}
