part of 'bmi_bloc.dart';

class BmiState extends Equatable {
  final List<Unit> heightUnits;
  final List<Unit> weightUnits;
  final Unit? heightUnit;
  final double? height;
  final String? heightValidation;
  final Unit? weightUnit;
  final double? weight;
  final String? weightValidation;
  final Bmi? bmi;

  const BmiState({
    this.heightUnits = const [],
    this.weightUnits = const [],
    this.heightUnit,
    this.height,
    this.heightValidation,
    this.weightUnit,
    this.weight,
    this.weightValidation,
    this.bmi,
  });

  BmiState copyWith({
    List<Unit>? heightUnits,
    List<Unit>? weightUnits,
    Unit? Function()? heightUnit,
    double? Function()? height,
    String? Function()? heightValidation,
    Unit? Function()? weightUnit,
    double? Function()? weight,
    String? Function()? weightValidation,
    Bmi? Function()? bmi,
  }) {
    return BmiState(
      heightUnits: heightUnits ?? this.heightUnits,
      weightUnits: weightUnits ?? this.weightUnits,
      heightUnit: heightUnit != null ? heightUnit() : this.heightUnit,
      height: height != null ? height() : this.height,
      heightValidation:
          heightValidation != null ? heightValidation() : this.heightValidation,
      weightUnit: weightUnit != null ? weightUnit() : this.weightUnit,
      weight: weight != null ? weight() : this.weight,
      weightValidation:
          weightValidation != null ? weightValidation() : this.weightValidation,
      bmi: bmi != null ? bmi() : this.bmi,
    );
  }

  @override
  String toString() {
    return 'BmiState(heightUnits: $heightUnits, weightUnits: $weightUnits, heightUnit: $heightUnit, height: $height, heightValidation: $heightValidation, weightUnit: $weightUnit, weight: $weight, weightValidation: $weightValidation, bmi: $bmi)';
  }

  @override
  List<Object?> get props {
    return [
      heightUnits,
      weightUnits,
      heightUnit,
      height,
      heightValidation,
      weightUnit,
      weight,
      weightValidation,
      bmi,
    ];
  }
}
