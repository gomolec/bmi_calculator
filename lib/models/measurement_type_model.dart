enum MeasurementType {
  meters("m", false, "m", ""),
  centimeters("cm", false, "cm", ""),
  feetAndInches("ft+in", true, "ft", "in"),
  kilograms("kg", false, "kg", ""),
  pounds("lb", false, "lb", "");

  final String text;
  final bool isSecondaryFieldNeeded;
  final String primaryHint;
  final String secondaryHint;

  const MeasurementType(
    this.text,
    this.isSecondaryFieldNeeded,
    this.primaryHint,
    this.secondaryHint,
  );
}
