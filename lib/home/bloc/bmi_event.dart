part of 'bmi_bloc.dart';

abstract class BmiEvent extends Equatable {
  const BmiEvent();

  @override
  List<Object> get props => [];
}

class BmiSubscriptionRequested extends BmiEvent {
  const BmiSubscriptionRequested();
}

class BmiHeightChanged extends BmiEvent {
  final String primaryValue;
  final String secondaryValue;

  const BmiHeightChanged({
    required this.primaryValue,
    required this.secondaryValue,
  });
}

class BmiWeightChanged extends BmiEvent {
  final String primaryValue;
  final String secondaryValue;

  const BmiWeightChanged({
    required this.primaryValue,
    required this.secondaryValue,
  });
}

class BmiHeightUnitChanged extends BmiEvent {
  final Unit unit;

  const BmiHeightUnitChanged({
    required this.unit,
  });
}

class BmiWeightUnitChanged extends BmiEvent {
  final Unit unit;

  const BmiWeightUnitChanged({
    required this.unit,
  });
}

class BmiValuesCleared extends BmiEvent {
  const BmiValuesCleared();
}
