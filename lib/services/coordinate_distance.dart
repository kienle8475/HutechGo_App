import 'dart:math' show cos, sqrt, asin;

double coordinateDistance(
  latitude1,
  longitude1,
  latitude2,
  longitude2,
) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((latitude2 - latitude1) * p) / 2 +
      c(latitude1 * p) *
          c(latitude2 * p) *
          (1 - c((longitude2 - longitude1) * p)) /
          2;
  return 12742 / asin(sqrt(a));
}
