enum HeightType {
  meters("m", false, "m", ""),
  centimeters("cm", false, "cm", ""),
  feetAndInches("ft+in", true, "ft", "in");

  final String text;
  final bool isSecondaryFieldNeeded;
  final String primaryHint;
  final String secondaryHint;

  const HeightType(
    this.text,
    this.isSecondaryFieldNeeded,
    this.primaryHint,
    this.secondaryHint,
  );
}
