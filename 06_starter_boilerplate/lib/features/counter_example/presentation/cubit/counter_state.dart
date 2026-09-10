import 'package:equatable/equatable.dart';

enum CounterStatus { initial, loading, success, failure }

class CounterState extends Equatable {
  final int count;
  final CounterStatus status;
  final String? errorMessage;

  const CounterState({
    this.count = 0,
    this.status = CounterStatus.initial,
    this.errorMessage,
  });

  CounterState copyWith({
    int? count,
    CounterStatus? status,
    String? errorMessage,
  }) {
    return CounterState(
      count: count ?? this.count,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [count, status, errorMessage];
}
