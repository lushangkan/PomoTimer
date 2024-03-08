String camelToSnakeCase(String input) {
  return input.replaceAllMapped(
    RegExp(r'(?<=[a-z])[A-Z]'),
        (Match m) => '_${m[0]!.toLowerCase()}',
  );
}