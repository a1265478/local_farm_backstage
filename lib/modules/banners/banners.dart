import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/modules/banners/cubit/banner_cubit.dart';
import 'package:local_farm_backstage/widgets/action_button.dart';
import 'package:local_farm_backstage/widgets/disable_action_button.dart';
import 'package:local_farm_backstage/widgets/update_result_snake_bar.dart';
import 'package:local_farm_backstage/widgets/upload_image.dart';

class Banners extends StatelessWidget {
  const Banners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerCubit()..getData(),
      child: BlocListener<BannerCubit, BannerState>(
        listener: (context, state) {
          if (state.uploadStatus == Status.success ||
              state.uploadStatus == Status.failure) {
            UpdateResultSnakeBar.show(context, result: state.uploadStatus);
          }
        },
        child: SingleChildScrollView(
          padding: kPagePadding,
          key: const PageStorageKey("banner"),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<BannerCubit, BannerState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      ActionButton(
                        title: "選擇圖片",
                        onPressed: () {
                          BlocProvider.of<BannerCubit>(context).chooseFile();
                        },
                      ),
                      const SizedBox(width: 10),
                      state.uploadStatus == Status.working
                          ? const DisableActionButton()
                          : ActionButton(
                              onPressed: () {
                                BlocProvider.of<BannerCubit>(context)
                                    .submitImageFile();
                              },
                            ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Banner 標準比例： 970 x 250", style: kImportant),
              ),
              BlocBuilder<BannerCubit, BannerState>(
                builder: (context, state) {
                  return Wrap(
                    runSpacing: 5,
                    children: [
                      ...state.imageList.map(
                        (e) => UploadImage(
                          ratio: 970 / 250,
                          imageFile: e,
                          onDelete: () {
                            BlocProvider.of<BannerCubit>(context)
                                .deleteImage(e.filename);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
