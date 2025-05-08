extension NullableObjectExtensions on Object? {
  bool get isEmptyOrNull {
    if (this == null) return true;
    if (this is String || this is Iterable || this is Map) {
      return (this as dynamic).isEmpty;
    }
    return false;
  }

  bool get isNotEmptyOrNull => !isEmptyOrNull;
}
