import 'package:bmi_calculator/calculator_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calculator_bloc.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorBloc(
        calculatorRepository: context.read<CalculatorRepository>(),
      ),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text("Kalkulator BMI"),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<CalculatorBloc>().add(const ValuesCleared());
                },
                icon: const Icon(Icons.restart_alt_rounded),
              ),
            ],
          ),
          const MeasurementsCard(),
          const ResultsCard(),
          const BmiTypesList(),
        ],
      ),
    );
  }
}
