part of 'banner_cubit.dart';

class BannerState extends Equatable {
  const BannerState({
    this.imageList = const [],
    this.uploadStatus = Status.init,
  });

  final List<ImageFile> imageList;
  final Status uploadStatus;

  BannerState copyWith({
    List<ImageFile>? imageList,
    Status? uploadStatus,
  }) {
    return BannerState(
      imageList: imageList ?? this.imageList,
      uploadStatus: uploadStatus ?? this.uploadStatus,
    );
  }

  @override
  List<Object> get props => [imageList, uploadStatus];
}

class BannerInitial extends BannerState {}
