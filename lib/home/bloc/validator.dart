class Validator {
  String? validate({
    required String primaryValue,
    required String secondaryValue,
  }) {
    if (primaryValue.isEmpty && secondaryValue.isEmpty) {
      return "Nie może być puste";
    }

    if (double.tryParse(primaryValue) == null &&
        double.tryParse(secondaryValue) == null) {
      return "Niewłaściwe dane";
    }

    if ((double.tryParse(primaryValue) ?? 0.0) <= 0.0 &&
        (double.tryParse(secondaryValue) ?? 0.0) <= 0.0) {
      return "Nieprawidłowa wartość";
    }

    return null;
  }
}
