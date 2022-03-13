import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/widgets/action_button.dart';

import 'cubit/download_cubit.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<DownloadCubit, DownloadState>(
                builder: (context, state) {
                  return ActionButton(
                    title: "選擇檔案",
                    onPressed: () {
                      BlocProvider.of<DownloadCubit>(context).uploadFile();
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<DownloadCubit, DownloadState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.downloadList.length,
                    itemBuilder: (_, index) => ListTile(
                      title: Text(state.downloadList[index].filename),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          BlocProvider.of<DownloadCubit>(context)
                              .removeFile(state.downloadList[index].id);
                        },
                      ),
                    ),
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
