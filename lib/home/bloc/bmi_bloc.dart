import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/models/models.dart';
import 'package:bmi_calculator/repositories/bmi_repository.dart';
import 'package:equatable/equatable.dart';

import 'inputs_validator.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc({
    required BmiRepository bmiRepository,
    required InputsValidator validator,
  })  : _bmiRepository = bmiRepository,
        _validator = validator,
        super(const BmiState()) {
    on<BmiSubscriptionRequested>(_onSubscriptionRequested);
    on<BmiHeightChanged>(_onHeightChanged);
    on<BmiWeightChanged>(_onWeightChanged);
    on<BmiHeightUnitChanged>(_onHeightUnitChanged);
    on<BmiWeightUnitChanged>(_onWeightUnitChanged);
    on<BmiValuesCleared>(_onValuesCleared);
  }

  final BmiRepository _bmiRepository;
  final InputsValidator _validator;

  void _onSubscriptionRequested(
    BmiSubscriptionRequested event,
    Emitter<BmiState> emit,
  ) {
    emit(state.copyWith(
      heightUnits: _bmiRepository.measurementUnits
          .where((element) => element.type == UnitType.height)
          .toList(),
      weightUnits: _bmiRepository.measurementUnits
          .where((element) => element.type == UnitType.weight)
          .toList(),
      heightUnit: () => _bmiRepository.defaultHeightUnit,
      weightUnit: () => _bmiRepository.defaultWeightUnit,
    ));
  }

  void _onHeightChanged(
    BmiHeightChanged event,
    Emitter<BmiState> emit,
  ) {
    final String? heightValidation = _validator.validate(
      primaryValue: event.primaryValue,
      secondaryValue: event.secondaryValue,
    );

    if (heightValidation != null) {
      emit(state.copyWith(
        bmi: () => null,
        height: () => null,
        heightValidation: () => heightValidation,
      ));
      return;
    }

    double primaryValue = double.tryParse(event.primaryValue) ?? 0.0;
    double secondaryValue = double.tryParse(event.secondaryValue) ?? 0.0;

    double height = state.heightUnit != null
        ? state.heightUnit!.conversionFunction(primaryValue, secondaryValue)
        : 0.0;

    Bmi? bmi;

    if (state.weight != null && height != 0.0 && state.weight != 0.0) {
      bmi = _bmiRepository.calculateBmi(
        height: height,
        weight: state.weight!,
      );
    }

    emit(state.copyWith(
      bmi: () => bmi,
      height: () => height,
      heightValidation: () => heightValidation,
    ));

    return;
  }

  void _onWeightChanged(
    BmiWeightChanged event,
    Emitter<BmiState> emit,
  ) {
    final String? weightValidation = _validator.validate(
      primaryValue: event.primaryValue,
      secondaryValue: event.secondaryValue,
    );

    if (weightValidation != null) {
      emit(state.copyWith(
        bmi: () => null,
        weight: () => null,
        weightValidation: () => weightValidation,
      ));
      return;
    }

    double primaryValue = double.tryParse(event.primaryValue) ?? 0.0;
    double secondaryValue = double.tryParse(event.secondaryValue) ?? 0.0;

    double weight = state.weightUnit != null
        ? state.weightUnit!.conversionFunction(primaryValue, secondaryValue)
        : 0.0;

    Bmi? bmi;

    if (state.height != null && weight != 0.0 && state.height != 0.0) {
      bmi = _bmiRepository.calculateBmi(
        height: state.height!,
        weight: weight,
      );
    }

    emit(state.copyWith(
      bmi: () => bmi,
      weight: () => weight,
      weightValidation: () => weightValidation,
    ));

    return;
  }

  void _onHeightUnitChanged(
    BmiHeightUnitChanged event,
    Emitter<BmiState> emit,
  ) {
    emit(state.copyWith(
      bmi: () => null,
      heightUnit: () => event.unit,
      height: () => null,
      heightValidation: () => null,
    ));
  }

  void _onWeightUnitChanged(
    BmiWeightUnitChanged event,
    Emitter<BmiState> emit,
  ) {
    emit(state.copyWith(
      bmi: () => null,
      weightUnit: () => event.unit,
      weight: () => null,
      weightValidation: () => null,
    ));
  }

  void _onValuesCleared(
    BmiValuesCleared event,
    Emitter<BmiState> emit,
  ) {
    emit(state.copyWith(
      heightUnit: () => _bmiRepository.defaultHeightUnit,
      height: () => null,
      heightValidation: () => null,
      weightUnit: () => _bmiRepository.defaultWeightUnit,
      weight: () => null,
      weightValidation: () => null,
      bmi: () => null,
    ));
  }
}
