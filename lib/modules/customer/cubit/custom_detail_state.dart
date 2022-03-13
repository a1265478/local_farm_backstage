part of 'custom_detail_cubit.dart';

class CustomDetailState extends Equatable {
  const CustomDetailState({
    this.editCustomer = Customer.empty,
    this.customerList = const [],
    this.uploadStatus = Status.init,
    this.loadStatus = Status.init,
  });

  final Customer editCustomer;

  final List<Customer> customerList;
  final Status uploadStatus;
  final Status loadStatus;

  CustomDetailState copyWith({
    Customer? editCustomer,
    List<Customer>? customerList,
    Status? uploadStatus,
    Status? loadStatus,
  }) {
    return CustomDetailState(
      editCustomer: editCustomer ?? this.editCustomer,
      customerList: customerList ?? this.customerList,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  @override
  List<Object> get props =>
      [editCustomer, customerList, uploadStatus, loadStatus];
}

class CustomDetailInitial extends CustomDetailState {}
