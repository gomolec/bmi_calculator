import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/calculator_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import 'validator.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc({
    required CalculatorRepository calculatorRepository,
  })  : _calculatorRepository = calculatorRepository,
        super(const CalculatorState()) {
    on<HeightChanged>(_heightChanged);
    on<WeightChanged>(_weightChanged);
    on<HeightTypeChanged>(_heightTypeChanged);
    on<WeightTypeChanged>(_weightTypeChanged);
    on<ValuesCleared>(_valuesCleared);
  }

  final CalculatorRepository _calculatorRepository;
  final Validator _validator = Validator();

  void _heightChanged(
    HeightChanged event,
    Emitter<CalculatorState> emit,
  ) {
    String? validation = _validator.validate(
      primaryValue: event.primaryValue,
      secondaryValue: event.secondaryValue,
    );

    if (validation != null) {
      emit(state.copyWith(
        bmiResult: 0.0,
        bmiType: () => null,
        height: () => 0.0,
        heightValidation: () => validation,
      ));
    } else {
      double primaryValue = double.tryParse(event.primaryValue) ?? 0.0;
      double secondaryValue = double.tryParse(event.secondaryValue) ?? 0.0;

      double height = 0.0;

      if (state.heightType == MeasurementType.meters) {
        height = primaryValue;
      } else if (state.heightType == MeasurementType.centimeters) {
        height = _calculatorRepository.centimetersToMeters(
          centimeters: primaryValue,
        );
      } else if (state.heightType == MeasurementType.feetAndInches) {
        height = _calculatorRepository.feetAndInchesToMeters(
          feets: primaryValue,
          inches: secondaryValue,
        );
      }

      if (state.weight != null && height != 0.0 && state.weight != 0.0) {
        double bmi = _calculatorRepository.calculate(
          height: height,
          weight: state.weight!,
        );
        emit(state.copyWith(
          bmiResult: bmi,
          bmiType: () => _calculatorRepository.getBmiType(bmi),
          height: () => height,
          heightValidation: () => validation,
        ));
      } else {
        emit(state.copyWith(
          bmiResult: 0.0,
          bmiType: () => null,
          height: () => height,
          heightValidation: () => validation,
        ));
      }
    }
  }

  void _weightChanged(
    WeightChanged event,
    Emitter<CalculatorState> emit,
  ) {
    String? validation = _validator.validate(
      primaryValue: event.primaryValue,
      secondaryValue: event.secondaryValue,
    );

    if (validation != null) {
      emit(state.copyWith(
        bmiResult: 0.0,
        bmiType: () => null,
        weight: () => 0.0,
        weightValidation: () => validation,
      ));
    } else {
      double primaryValue = double.tryParse(event.primaryValue) ?? 0.0;
      double secondaryValue = double.tryParse(event.secondaryValue) ?? 0.0;

      double weight = 0.0;

      if (primaryValue != 0.0 || secondaryValue != 0.0) {
        if (state.weightType == MeasurementType.kilograms) {
          weight = primaryValue;
        } else if (state.weightType == MeasurementType.pounds) {
          weight = _calculatorRepository.poundsToKilograms(
            pounds: primaryValue,
          );
        }
      }

      if (state.height != null && state.height != 0.0 && weight != 0.0) {
        double bmi = _calculatorRepository.calculate(
          height: state.height!,
          weight: weight,
        );
        emit(state.copyWith(
          bmiResult: bmi,
          bmiType: () => _calculatorRepository.getBmiType(bmi),
          weight: () => weight,
          weightValidation: () => validation,
        ));
      } else {
        emit(state.copyWith(
          bmiResult: 0.0,
          bmiType: () => null,
          weight: () => weight,
          weightValidation: () => validation,
        ));
      }
    }
  }

  void _heightTypeChanged(
    HeightTypeChanged event,
    Emitter<CalculatorState> emit,
  ) {
    emit(state.copyWith(
      bmiType: () => null,
      bmiResult: 0.0,
      heightType: event.type,
      height: () => null,
      heightValidation: () => null,
    ));
  }

  void _weightTypeChanged(
    WeightTypeChanged event,
    Emitter<CalculatorState> emit,
  ) {
    emit(state.copyWith(
      bmiType: () => null,
      bmiResult: 0.0,
      weightType: event.type,
      weight: () => null,
      weightValidation: () => null,
    ));
  }

  void _valuesCleared(
    ValuesCleared event,
    Emitter<CalculatorState> emit,
  ) {
    emit(const CalculatorState());
  }
}
