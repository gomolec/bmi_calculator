enum WeightType {
  kilograms("kg", false, "kg", ""),
  pounds("lb", false, "lb", "");

  final String text;
  final bool isSecondaryFieldNeeded;
  final String primaryHint;
  final String secondaryHint;

  const WeightType(
    this.text,
    this.isSecondaryFieldNeeded,
    this.primaryHint,
    this.secondaryHint,
  );
}
