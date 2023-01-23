import 'package:equatable/equatable.dart';

enum UnitType { height, weight }

class Unit extends Equatable {
  final String name;
  final UnitType type;
  final String abbreviation;
  final String primaryText;
  final String? secondaryText;
  final double Function(double, double?) conversionFunction;

  const Unit({
    required this.name,
    required this.type,
    required this.abbreviation,
    required this.primaryText,
    this.secondaryText,
    required this.conversionFunction,
  });

  bool get isTwoPart => secondaryText != null;

  @override
  String toString() {
    return 'Unit(name: $name, type: $type, abbreviation: $abbreviation, primaryText: $primaryText, secondaryText: $secondaryText, conversionFunction: $conversionFunction)';
  }

  Unit copyWith({
    String? name,
    UnitType? type,
    String? abbreviation,
    String? primaryText,
    String? secondaryText,
    double Function(double, double?)? conversionFunction,
  }) {
    return Unit(
      name: name ?? this.name,
      type: type ?? this.type,
      abbreviation: abbreviation ?? this.abbreviation,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      conversionFunction: conversionFunction ?? this.conversionFunction,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      type,
      abbreviation,
      primaryText,
      secondaryText,
      conversionFunction,
    ];
  }
}
