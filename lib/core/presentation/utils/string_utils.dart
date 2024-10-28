class StringUtils {
  static String capitalizeFirst(String text) {
    if (text.isEmpty) {
      return text;
    }
    final List<String> split = text.trim().split(' ');
    if (split.isEmpty) {
      return text;
    }

    final List<String> newList = split
        .map((String st) =>
            '${st[0].toUpperCase()}${st.substring(1, st.length).toLowerCase()}')
        .toList();
    return newList.join(' ');
  }

  static String formatName(String text) {
    if (text.isEmpty) {
      return text;
    }

    final List<String> split = text.trim().split('-');
    if (split.isEmpty) {
      return text;
    }

    final List<String> newList = split.map((String st) {
      if (st.isEmpty) {
        return '';
      }
      if (st.length == 1) {
        return st[0].toUpperCase();
      }
      return '${st[0].toUpperCase()}${st.substring(1, st.length).toLowerCase()}';
    }).toList();
    return newList.join('-');
  }
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((String str) => str.toCapitalized()).join(' ');
}
