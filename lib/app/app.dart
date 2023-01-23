import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home.dart';
import '../repositories/bmi_repository.dart';
import '../theme/theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.bmiRepository,
  });

  final BmiRepository bmiRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: bmiRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const HomePage(),
    );
  }
}
