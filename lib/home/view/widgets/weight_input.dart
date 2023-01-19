import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bmi_calculator/home/bloc/calculator_bloc.dart';
import 'package:bmi_calculator/models/models.dart';

class WeightInput extends StatelessWidget {
  const WeightInput({
    Key? key,
  }) : super(key: key);

  final MeasurementType initialType = MeasurementType.kilograms;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CustomTextFields(initialType: initialType),
            const SizedBox(
              width: 16.0,
            ),
            _CustomDropdownField(initialType: initialType),
          ],
        ),
        const _ValidationText(),
      ],
    );
  }
}

class _CustomDropdownField extends StatelessWidget {
  final MeasurementType initialType;

  const _CustomDropdownField({
    Key? key,
    required this.initialType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MeasurementType type = initialType;
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) =>
          previous.weightType != current.weightType,
      builder: (context, state) {
        type = state.weightType;
        return Expanded(
          child: DropdownButtonFormField<MeasurementType>(
            value: type,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            isExpanded: true,
            items: [
              DropdownMenuItem(
                value: MeasurementType.kilograms,
                child: Text(MeasurementType.kilograms.text),
              ),
              DropdownMenuItem(
                value: MeasurementType.pounds,
                child: Text(MeasurementType.pounds.text),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                context
                    .read<CalculatorBloc>()
                    .add(WeightTypeChanged(type: value));
              }
            },
          ),
        );
      },
    );
  }
}

class _CustomTextFields extends StatefulWidget {
  final MeasurementType initialType;

  const _CustomTextFields({
    Key? key,
    required this.initialType,
  }) : super(key: key);

  @override
  State<_CustomTextFields> createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<_CustomTextFields> {
  late final TextEditingController _primaryController;
  late final TextEditingController _secondaryController;

  late MeasurementType type;
  String? validation;

  @override
  void initState() {
    _primaryController = TextEditingController();
    _secondaryController = TextEditingController();
    type = widget.initialType;
    super.initState();
  }

  void onChanged() {
    context.read<CalculatorBloc>().add(
          WeightChanged(
            primaryValue: _primaryController.text,
            secondaryValue: _secondaryController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalculatorBloc, CalculatorState>(
      listenWhen: (previous, current) {
        if (previous.weight != current.weight) {
          return true;
        }
        if (previous.weightType != current.weightType) {
          return true;
        }
        if (previous.weightValidation != current.weightValidation) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (type != state.weightType) {
          type = state.weightType;
        }
        if (state.weight == null) {
          _primaryController.clear();
          _secondaryController.clear();
        }
        validation = state.weightValidation;

        setState(() {});
      },
      child: Expanded(
        flex: 2,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _primaryController,
                decoration: InputDecoration(
                  hintText: type.primaryHint,
                  border: const OutlineInputBorder(),
                  errorStyle: const TextStyle(
                    height: 0.01,
                    color: Colors.transparent,
                  ),
                  errorText: validation,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                ],
                onChanged: (value) => onChanged(),
              ),
            ),
            SizedBox(
              width: type.isSecondaryFieldNeeded ? 8.0 : 0.0,
            ),
            type.isSecondaryFieldNeeded
                ? Expanded(
                    child: TextFormField(
                      controller: _secondaryController,
                      decoration: InputDecoration(
                        hintText: type.secondaryHint,
                        border: const OutlineInputBorder(),
                        errorStyle: const TextStyle(
                          height: 0.01,
                          color: Colors.transparent,
                        ),
                        errorText: validation,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                      ],
                      onChanged: (value) => onChanged(),
                      validator: (value) => validation,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _ValidationText extends StatelessWidget {
  const _ValidationText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) =>
          previous.weightValidation != current.weightValidation,
      builder: (context, state) {
        return state.weightValidation != null
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.weightValidation!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
