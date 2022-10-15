/// Safely unpack an integer value from a [Map] object.
int? unpackInt(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final dynamic val = M[k];
      if (val is String) {
        return int.tryParse(val);
      } else if (val is int) {
        return val;
      }
    }
  }
  return null;
}

/// Safely unpack a double value from a [Map] object.
double? unpackDouble(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final dynamic val = M[k];
      if (val is String) {
        return double.tryParse(val);
      } else if (val is num) {
        return val.toDouble();
      }
    }
  }
  return null;
}

/// Safely unpack a string value from a [Map] object.
String? unpackString(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      return M[k] as String?;
    }
  }
  return null;
}

/// Safely unpack List object.
List? unpackList(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      return M[k] as List?;
    }
  }
  return null;
}

/// Safely unpack Map object.
Map? unpackMap(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      return M[k] as Map?;
    }
  }
  return null;
}

/// Safely unpacks a unix timestamp from a [Map] object,
/// i.e. an integer value of milliseconds and converts this to a [DateTime] object.
DateTime? unpackDate(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      if (M[k] is int) {
        final int millis = (M[k] as int) * 1000;
        return DateTime.fromMillisecondsSinceEpoch(millis);
      }
    }
  }
  return null;
}
