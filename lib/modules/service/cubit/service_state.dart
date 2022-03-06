part of 'service_cubit.dart';

class ServiceState extends Equatable {
  const ServiceState({
    this.serviceList = const [],
    this.editService = Service.empty,
    this.saveStatus = Status.init,
  });

  final List<Service> serviceList;
  final Service editService;
  final Status saveStatus;

  ServiceState copyWith({
    List<Service>? serviceList,
    Service? editService,
    Status? saveStatus,
  }) {
    return ServiceState(
      serviceList: serviceList ?? this.serviceList,
      editService: editService ?? this.editService,
      saveStatus: saveStatus ?? this.saveStatus,
    );
  }

  @override
  List<Object> get props => [serviceList, editService, saveStatus];
}

class ServiceInitial extends ServiceState {}
