import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A custom BlocObserver that logs bloc events, transitions, errors and changes
/// for debugging. Only logs when [kDebugMode] is true.
class CustomBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      debugPrint('🟢 onCreate: ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      debugPrint('📥 onEvent: ${bloc.runtimeType} | $event');
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      debugPrint(
        '🔄 onChange: ${bloc.runtimeType}\n'
        '   current: ${change.currentState}\n'
        '   next: ${change.nextState}',
      );
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      debugPrint(
        '➡️ onTransition: ${bloc.runtimeType}\n'
        '   event: ${transition.event}\n'
        '   from: ${transition.currentState}\n'
        '   to: ${transition.nextState}',
      );
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint(
        '❌ onError: ${bloc.runtimeType}\n'
        '   error: $error\n'
        '   stackTrace: $stackTrace',
      );
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    if (kDebugMode) {
      debugPrint('🔴 onClose: ${bloc.runtimeType}');
    }
    super.onClose(bloc);
  }
}
