part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class HeightChanged extends CalculatorEvent {
  final String primaryValue;
  final String secondaryValue;

  const HeightChanged({
    required this.primaryValue,
    required this.secondaryValue,
  });
}

class WeightChanged extends CalculatorEvent {
  final String primaryValue;
  final String secondaryValue;

  const WeightChanged({
    required this.primaryValue,
    required this.secondaryValue,
  });
}

class HeightTypeChanged extends CalculatorEvent {
  final MeasurementType type;

  const HeightTypeChanged({
    required this.type,
  });
}

class WeightTypeChanged extends CalculatorEvent {
  final MeasurementType type;

  const WeightTypeChanged({
    required this.type,
  });
}

class ValuesCleared extends CalculatorEvent {
  const ValuesCleared();
}
