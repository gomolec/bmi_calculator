import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'repositories/bmi_repository.dart';

void bootstrap() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  final calculatorRepository = BmiRepository();

  runZonedGuarded(
    () => runApp(App(bmiRepository: calculatorRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
