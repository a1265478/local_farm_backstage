import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/modules/line_content/cubit/line_content_cubit.dart';
import 'package:local_farm_backstage/widgets/action_button.dart';
import 'package:local_farm_backstage/widgets/disable_action_button.dart';
import 'package:local_farm_backstage/widgets/update_result_snake_bar.dart';
import 'package:local_farm_backstage/widgets/upload_image.dart';

class LineContentPage extends StatelessWidget {
  const LineContentPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LineContentCubit()..getData(),
      child: BlocListener<LineContentCubit, LineContentState>(
        listener: (context, state) {
          if (state.updateStatus == Status.success ||
              state.updateStatus == Status.failure) {
            UpdateResultSnakeBar.show(context, result: state.updateStatus);
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            padding: kPagePadding,
            key: const PageStorageKey("lineContent"),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<LineContentCubit, LineContentState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        ActionButton(
                          title: "選擇圖片",
                          onPressed: () {
                            BlocProvider.of<LineContentCubit>(context)
                                .chooseFile();
                          },
                        ),
                        const SizedBox(width: 10),
                        state.updateStatus == Status.working
                            ? const DisableActionButton()
                            : ActionButton(
                                onPressed: () {
                                  BlocProvider.of<LineContentCubit>(context)
                                      .submitImageFile();
                                },
                              ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("圖片標準比例： 1250 x 843", style: kImportant),
                ),
                BlocBuilder<LineContentCubit, LineContentState>(
                  builder: (context, state) {
                    return Wrap(
                      runSpacing: 5,
                      spacing: 10,
                      children: [
                        ...state.imageList.map(
                          (e) => SizedBox(
                            width: MediaQuery.of(context).size.width / 4 < 300
                                ? 300
                                : MediaQuery.of(context).size.width / 4,
                            child: UploadImage(
                              ratio: (1250 / 3) / (843 / 3),
                              imageFile: e,
                              onDelete: () {
                                BlocProvider.of<LineContentCubit>(context)
                                    .deleteImage(e.filename);
                              },
                            ),
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
      ),
    );
  }
}
