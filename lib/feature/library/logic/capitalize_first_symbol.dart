class StringHelper {
  static String capitalizeFirstSymbol(String donor) {
    String result = donor[0].toUpperCase() + donor.substring(1);
    return result;
  }
}
