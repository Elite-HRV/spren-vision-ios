enum SprenAction { increase, decrease }

enum SprenReadingStatus {
  preReading,
  reading,
}
enum SprenComplicanceChecks {
  frameDrop,
  brightness,
  lensCoverage,
}

enum SprenState {
  preReading,
  started,
  finished,
  cancelled,
  error,
}

extension SprenReadingStatusParseToString on SprenReadingStatus {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension StateParseToString on SprenState {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension SprenComplicanceChecksToString on SprenComplicanceChecks {
  String toShortString() {
    return toString().split('.').last;
  }
}
