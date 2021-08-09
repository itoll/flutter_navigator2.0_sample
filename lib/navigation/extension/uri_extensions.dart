extension UriExtension on Uri {
  bool formatIsEqualTo(Uri uri) {
    var currentUrl = toString();
    var inputUrl = uri.toString();

    var currentUrlFormatted = currentUrl.replaceAll(RegExp('/:\\w*'), '');
    currentUrlFormatted = currentUrlFormatted.replaceAll(RegExp('-'), '');
    var inputUrlFormatted = inputUrl.replaceAll(RegExp('/:\\w*'), '');
    inputUrlFormatted = inputUrlFormatted.replaceAll(RegExp('-'), '');

    if (currentUrlFormatted.startsWith(inputUrlFormatted) || inputUrlFormatted.startsWith(currentUrlFormatted)) {
      return true;
    }

    return false;
  }
}
