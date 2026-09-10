import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_state.dart';

/// Cubit yang mengelola logika penambahan, pengurangan, dan reset counter.
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState());

  void increment() {
    emit(state.copyWith(
      count: state.count + 1,
      status: CounterStatus.success,
    ));
  }

  void decrement() {
    if (state.count <= 0) {
      emit(state.copyWith(
        status: CounterStatus.failure,
        errorMessage: 'Angka tidak boleh kurang dari 0!',
      ));
      return;
    }

    emit(state.copyWith(
      count: state.count - 1,
      status: CounterStatus.success,
      errorMessage: null,
    ));
  }

  void reset() {
    emit(const CounterState(
      count: 0,
      status: CounterStatus.initial,
    ));
  }
}
