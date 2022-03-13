part of 'info_cubit.dart';

class InfoState extends Equatable {
  const InfoState({
    this.info = Info.empty,
    this.saveStatus = Status.init,
  });

  final Info info;
  final Status saveStatus;

  InfoState copyWith({
    Info? info,
    Status? saveStatus,
  }) {
    return InfoState(
      info: info ?? this.info,
      saveStatus: saveStatus ?? this.saveStatus,
    );
  }

  @override
  List<Object> get props => [info, saveStatus];
}

class InfoInitial extends InfoState {}
