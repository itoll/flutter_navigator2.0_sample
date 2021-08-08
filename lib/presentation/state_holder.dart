import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class StateHolder<T> extends Equatable {
  StateHolder.empty() : status = Status.EMPTY;

  StateHolder.loading({this.data}) {
    status = Status.LOADING;
  }

  StateHolder.completed(this.data) : status = Status.COMPLETED;

  StateHolder.error({this.failure, T? data}) {
    status = Status.ERROR;
    data = data ?? this.data;
  }

  Status? status;
  T? data;
  Exception? failure;

  @override
  String toString() {
    return '\nStatus : $status';
  }

  @override
  List<Object?> get props => [status, data, failure];
}

enum Status { EMPTY, LOADING, COMPLETED, ERROR }
