part of 'introduction_cubit.dart';

class IntroductionState extends Equatable {
  const IntroductionState({
    this.introductionList = const [],
    this.updateStatus = Status.init,
  });
  final List<Introduction> introductionList;
  final Status updateStatus;

  IntroductionState copyWith(
      {List<Introduction>? introductionList, Status? updateStatus}) {
    return IntroductionState(
      introductionList: introductionList ?? this.introductionList,
      updateStatus: updateStatus ?? this.updateStatus,
    );
  }

  @override
  List<Object> get props => [introductionList, updateStatus];
}

class IntroductionInitial extends IntroductionState {}
