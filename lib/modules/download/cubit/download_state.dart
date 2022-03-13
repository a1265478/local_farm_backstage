part of 'download_cubit.dart';

class DownloadState extends Equatable {
  const DownloadState({
    this.downloadList = const [],
  });
  final List<Download> downloadList;

  DownloadState copyWith({
    List<Download>? downloadList,
  }) {
    return DownloadState(downloadList: downloadList ?? this.downloadList);
  }

  @override
  List<Object> get props => [downloadList];
}

class DownloadInitial extends DownloadState {}
