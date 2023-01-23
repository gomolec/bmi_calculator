import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/models.dart';

class MeasurementInput extends StatelessWidget {
  final TextEditingController primaryController;
  final TextEditingController secondaryController;
  final void Function() onValuesChanged;
  final void Function(Unit) onUnitChanged;
  final List<Unit> units;
  final Unit initialUnit;
  final String? validationText;

  const MeasurementInput({
    Key? key,
    required this.primaryController,
    required this.secondaryController,
    required this.onValuesChanged,
    required this.onUnitChanged,
    required this.units,
    required this.initialUnit,
    this.validationText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _CustomTextField(
                controller: primaryController,
                onChanged: onValuesChanged,
                hintText: initialUnit.primaryText,
                validationText: validationText,
              ),
            ),
            SizedBox(width: initialUnit.isTwoPart ? 8.0 : 0.0),
            initialUnit.isTwoPart
                ? Expanded(
                    child: _CustomTextField(
                      controller: secondaryController,
                      onChanged: onValuesChanged,
                      hintText: initialUnit.secondaryText,
                      validationText: validationText,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(width: 16.0),
            Expanded(
              child: _CustomDropdownField(
                onChanged: onUnitChanged,
                units: units,
                initialUnit: initialUnit,
              ),
            ),
          ],
        ),
        validationText != null
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  validationText!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _CustomDropdownField extends StatelessWidget {
  final Function(Unit) onChanged;
  final List<Unit> units;
  final Unit? initialUnit;

  const _CustomDropdownField({
    Key? key,
    required this.onChanged,
    required this.units,
    required this.initialUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Unit>(
      isExpanded: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        errorStyle: TextStyle(
          height: 0.01,
          color: Colors.transparent,
        ),
      ),
      value: initialUnit,
      items: units
          .map((unit) => DropdownMenuItem<Unit>(
                value: unit,
                child: Expanded(
                    child: Text(
                  unit.name,
                  overflow: TextOverflow.ellipsis,
                )),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? validationText;
  final void Function() onChanged;

  const _CustomTextField({
    Key? key,
    required this.controller,
    // ignore: unused_element
    this.hintText,
    // ignore: unused_element
    this.validationText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        errorStyle: const TextStyle(
          height: 0.01,
          color: Colors.transparent,
        ),
        errorText: validationText,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
      ],
      onChanged: (value) => onChanged(),
    );
  }
}
