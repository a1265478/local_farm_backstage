part of 'line_content_cubit.dart';

class LineContentState extends Equatable {
  const LineContentState({
    this.imageList = const [],
    this.updateStatus = Status.init,
  });

  final List<ImageFile> imageList;

  final Status updateStatus;

  LineContentState copyWith({
    List<ImageFile>? imageList,
    Status? updateStatus,
  }) {
    return LineContentState(
      imageList: imageList ?? this.imageList,
      updateStatus: updateStatus ?? this.updateStatus,
    );
  }

  @override
  List<Object> get props => [imageList, updateStatus];
}

class LineContentInitial extends LineContentState {}
