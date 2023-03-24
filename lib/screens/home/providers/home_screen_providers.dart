import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenProviders {
  static final opacityProvider = StateProvider<double>((ref) {
    return 0;
  });
}
