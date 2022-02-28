part of 'data_cubit.dart';

class DataState extends Equatable {
  const DataState({this.data = const {}, this.status = Status.init});

  final Map<String, dynamic> data;
  final Status status;

  DataState copyWith({Map<String, dynamic>? data, Status? status}) {
    return DataState(
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [data, status];
}

class DataInitial extends DataState {}
