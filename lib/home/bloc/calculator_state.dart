part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  final MeasurementType heightType;
  final double? height;
  final String? heightValidation;
  final MeasurementType weightType;
  final double? weight;
  final String? weightValidation;
  final BmiType? bmiType;
  final double bmiResult;

  const CalculatorState({
    this.heightType = MeasurementType.meters,
    this.height,
    this.heightValidation,
    this.weightType = MeasurementType.kilograms,
    this.weight,
    this.weightValidation,
    this.bmiType,
    this.bmiResult = 0.0,
  });

  CalculatorState copyWith({
    MeasurementType? heightType,
    double? Function()? height,
    String? Function()? heightValidation,
    MeasurementType? weightType,
    double? Function()? weight,
    String? Function()? weightValidation,
    BmiType? Function()? bmiType,
    double? bmiResult,
  }) {
    return CalculatorState(
      heightType: heightType ?? this.heightType,
      height: height != null ? height() : this.height,
      heightValidation:
          heightValidation != null ? heightValidation() : this.heightValidation,
      weightType: weightType ?? this.weightType,
      weight: weight != null ? weight() : this.weight,
      weightValidation:
          weightValidation != null ? weightValidation() : this.weightValidation,
      bmiType: bmiType != null ? bmiType() : this.bmiType,
      bmiResult: bmiResult ?? this.bmiResult,
    );
  }

  @override
  List<Object?> get props {
    return [
      heightType,
      height,
      heightValidation,
      weightType,
      weight,
      weightValidation,
      bmiType,
      bmiResult,
    ];
  }

  @override
  String toString() {
    return 'CalculatorState(heightType: $heightType, height: $height, heightValidation: $heightValidation, weightType: $weightType, weight: $weight, weightValidation: $weightValidation, bmiType: $bmiType, bmiResult: $bmiResult)';
  }
}
