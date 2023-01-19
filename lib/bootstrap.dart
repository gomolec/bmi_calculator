import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/calculator_repository.dart';
import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';

void bootstrap() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  final calculatorRepository = CalculatorRepository();

  runZonedGuarded(
    () => runApp(App(calculatorRepository: calculatorRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
