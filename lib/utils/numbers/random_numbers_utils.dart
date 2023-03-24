import 'dart:math';

/// Return a random number between min and max.
///
/// Args:
///   min (double): The minimum value of the range.
///   max (double): The maximum value of the random number.
///
/// Returns:
///   A random number between min and max.
double getRandomNumber(double min, double max) {
  return min + Random().nextDouble() * (max - min);
}
