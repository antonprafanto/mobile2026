import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Observer terpusat untuk memantau semua event, transisi, dan error pada BLoC/Cubit.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    debugPrint('🟢 [BLOC CREATED]: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint(
      '🔄 [BLOC CHANGE] ${bloc.runtimeType} -> Current: ${change.currentState} | Next: ${change.nextState}',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    debugPrint('🔴 [BLOC ERROR]: ${bloc.runtimeType} -> $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    debugPrint('⚪ [BLOC CLOSED]: ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
