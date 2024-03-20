class StringHelper {
  static String? capitalizeFirstSymbol(String? donor) =>
      donor != null ? donor[0].toUpperCase() + donor.substring(1) : null;
}
