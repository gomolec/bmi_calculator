import 'package:bmi_calculator/repositories/bmi_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BmiRepository sut;

  setUp(() {
    sut = BmiRepository();
  });

  group(
    "BMI calculation",
    () {
      test('calculating with meters and kilograms', () {
        final bmi = sut.calculateBmi(
          height: 1.8,
          weight: 60,
        );

        expect(bmi.value, 18.52);
      });
    },
  );
}
