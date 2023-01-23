import 'package:bmi_calculator/home/bloc/inputs_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/bmi_repository.dart';
import '../bloc/bmi_bloc.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiBloc(
        bmiRepository: context.read<BmiRepository>(),
        validator: InputsValidator(),
      )..add(const BmiSubscriptionRequested()),
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
          SliverAppBar.medium(
            title: const Text("Kalkulator BMI"),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<BmiBloc>().add(const BmiValuesCleared());
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
