import 'package:bmi_calculator/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bmi_bloc.dart';
import 'widgets.dart';

class MeasurementsCard extends StatelessWidget {
  const MeasurementsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pomiary",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 16.0,
              ),
              const _HeightInput(),
              const SizedBox(
                height: 8.0,
              ),
              const _WeightInput(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeightInput extends StatefulWidget {
  const _HeightInput({
    Key? key,
  }) : super(key: key);

  @override
  State<_HeightInput> createState() => _HeightInputState();
}

class _HeightInputState extends State<_HeightInput> {
  late final TextEditingController _primaryController;
  late final TextEditingController _secondaryController;

  @override
  void initState() {
    _primaryController = TextEditingController();
    _secondaryController = TextEditingController();
    super.initState();
  }

  void onValuesChanged() {
    context.read<BmiBloc>().add(
          BmiHeightChanged(
            primaryValue: _primaryController.text,
            secondaryValue: _secondaryController.text,
          ),
        );
  }

  void onUnitChanged(Unit unit) {
    context.read<BmiBloc>().add(
          BmiHeightUnitChanged(unit: unit),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Wzrost",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        BlocConsumer<BmiBloc, BmiState>(
          listenWhen: (previous, current) {
            if (previous.height != current.height) return true;
            return false;
          },
          listener: (context, state) {
            if (state.height == null) {
              _primaryController.clear();
              _secondaryController.clear();
            }
          },
          buildWhen: (previous, current) {
            if (previous.height != current.height && current.height == null) {
              return true;
            }

            if (previous.heightValidation != current.heightValidation) {
              return true;
            }

            if (previous.heightUnit != current.heightUnit) return true;

            if (previous.heightUnits != current.heightUnits) return true;

            return false;
          },
          builder: (context, state) => state.heightUnit != null
              ? MeasurementInput(
                  primaryController: _primaryController,
                  secondaryController: _secondaryController,
                  onValuesChanged: onValuesChanged,
                  onUnitChanged: onUnitChanged,
                  units: state.heightUnits,
                  initialUnit: state.heightUnit!,
                  validationText: state.heightValidation,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }
}

class _WeightInput extends StatefulWidget {
  const _WeightInput({
    Key? key,
  }) : super(key: key);

  @override
  State<_WeightInput> createState() => _WeightInputState();
}

class _WeightInputState extends State<_WeightInput> {
  late final TextEditingController _primaryController;
  late final TextEditingController _secondaryController;

  @override
  void initState() {
    _primaryController = TextEditingController();
    _secondaryController = TextEditingController();
    super.initState();
  }

  void onValuesChanged() {
    context.read<BmiBloc>().add(
          BmiWeightChanged(
            primaryValue: _primaryController.text,
            secondaryValue: _secondaryController.text,
          ),
        );
  }

  void onUnitChanged(Unit unit) {
    context.read<BmiBloc>().add(
          BmiWeightUnitChanged(unit: unit),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Waga",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        BlocConsumer<BmiBloc, BmiState>(
          listenWhen: (previous, current) {
            if (previous.weight != current.weight) return true;
            return false;
          },
          listener: (context, state) {
            if (state.weight == null) {
              _primaryController.clear();
              _secondaryController.clear();
            }
          },
          buildWhen: (previous, current) {
            if (previous.weight != current.weight && current.weight == null) {
              return true;
            }

            if (previous.weightValidation != current.weightValidation) {
              return true;
            }

            if (previous.weightUnit != current.weightUnit) return true;

            if (previous.weightUnits != current.weightUnits) return true;

            return false;
          },
          builder: (context, state) => state.weightUnit != null
              ? MeasurementInput(
                  primaryController: _primaryController,
                  secondaryController: _secondaryController,
                  onValuesChanged: onValuesChanged,
                  onUnitChanged: onUnitChanged,
                  units: state.weightUnits,
                  initialUnit: state.weightUnit!,
                  validationText: state.weightValidation,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }
}
