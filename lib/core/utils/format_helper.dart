class FormatHelper {
  static String formatDateToBR(String? date) {
    if (date == null || date.trim().isEmpty) return '';

    try {
      final partes = date.split('-');

      if (partes.length != 3) return date;

      return partes.reversed.join('/');
    } catch (e) {
      return date;
    }
  }

  static String formatDateToAPI(String? date) {
    if (date == null || date.trim().isEmpty) return '';

    try {
      final parts = date.split('/');

      if (parts.length != 3) return date;

      return parts.reversed.join('-');
    } catch (e) {
      return date;
    }
  }
}
