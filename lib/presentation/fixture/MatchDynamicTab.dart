
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchDynamicTabUseCase {
  bool shouldAddTab(dynamic state) {
    if (state is AsyncData) {
      return true;
    } else if (state is AsyncError) {
      return false;
    } else if (state is AsyncLoading) {
      return false;
    }
    return false;
  }
}