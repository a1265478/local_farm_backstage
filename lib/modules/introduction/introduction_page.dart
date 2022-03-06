import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/core/model/introduction.dart';
import 'package:local_farm_backstage/modules/introduction/cubit/introduction_cubit.dart';
import 'package:local_farm_backstage/widgets/action_button.dart';
import 'package:local_farm_backstage/widgets/disable_action_button.dart';
import 'package:local_farm_backstage/widgets/update_result_snake_bar.dart';

class IntroductionPage extends StatelessWidget {
  IntroductionPage({Key? key}) : super(key: key);
  final IntroductionCubit _introductionCubit = IntroductionCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _introductionCubit..getData(),
      child: BlocListener<IntroductionCubit, IntroductionState>(
        listener: (context, state) {
          if (state.updateStatus == Status.success ||
              state.updateStatus == Status.failure) {
            UpdateResultSnakeBar.show(context, result: state.updateStatus);
          }
        },
        child: SingleChildScrollView(
          padding: kPagePadding,
          key: const PageStorageKey("Introduction"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: BlocBuilder<IntroductionCubit, IntroductionState>(
                  builder: (context, state) {
                    return Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: [
                        ...List.generate(
                          state.introductionList.length,
                          (index) => _categoryForm(
                              context, state.introductionList[index]),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: _saveButton(),
              ),
              BlocBuilder<IntroductionCubit, IntroductionState>(
                builder: (context, state) {
                  return Text(
                    state.updateStatus == Status.failure ? "Error" : "",
                    style: kSubmitError,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryForm(BuildContext context, Introduction introduction) =>
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: kLightGreenColor, width: 3),
        ),
        width: 350,
        height: 400,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: introduction.title,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                label: Text("大標題"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kDarkGreenColor, width: 2.0),
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                BlocProvider.of<IntroductionCubit>(context)
                    .updateTitle(introduction.id, value);
              },
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 5, height: 5),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: introduction.items,
              maxLines: 11,
              decoration: const InputDecoration(
                label: Text("項目列表"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kDarkGreenColor, width: 2.0),
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                BlocProvider.of<IntroductionCubit>(context)
                    .updateItem(introduction.id, value);
              },
            ),
          ],
        ),
      );

  Widget _saveButton() => BlocBuilder<IntroductionCubit, IntroductionState>(
        builder: (context, state) {
          return state.updateStatus == Status.working
              ? const DisableActionButton()
              : ActionButton(
                  onPressed: () {
                    _introductionCubit.submitIntroduction();
                  },
                );
        },
      );
}
