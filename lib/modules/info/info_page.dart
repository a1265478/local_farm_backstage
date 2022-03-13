import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/widgets/action_button.dart';
import 'package:local_farm_backstage/widgets/update_result_snake_bar.dart';

import '../../const/const.dart';
import '../../widgets/disable_action_button.dart';
import 'cubit/info_cubit.dart';

class InfoPage extends StatelessWidget {
  InfoPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoCubit()..loadData(),
      child: BlocConsumer<InfoCubit, InfoState>(
        listenWhen: (previous, current) =>
            previous.saveStatus != current.saveStatus,
        listener: (context, state) {
          if (state.saveStatus == Status.success ||
              state.saveStatus == Status.failure) {
            UpdateResultSnakeBar.show(context, result: state.saveStatus);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: kPagePadding,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: state.info.sendEmail,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        label: Text("收件者"),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kDarkGreenColor, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<InfoCubit>(context)
                            .changeSendEmail(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "內容不得為空";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: state.info.email,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        label: Text("公司Email"),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kDarkGreenColor, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<InfoCubit>(context).changeEmail(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "內容不得為空";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: state.info.address,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        label: Text("公司地址"),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kDarkGreenColor, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<InfoCubit>(context)
                            .changeSendAddress(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "內容不得為空";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: state.info.phone,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        label: Text("公司電話"),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kDarkGreenColor, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<InfoCubit>(context)
                            .changeSendPhone(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "內容不得為空";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: state.info.mobilePhone,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        label: Text("行動電話"),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: kDarkGreenColor, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<InfoCubit>(context)
                            .changeSendMobilePhone(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "內容不得為空";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerRight,
                      child: state.saveStatus == Status.working
                          ? const DisableActionButton()
                          : ActionButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                BlocProvider.of<InfoCubit>(context).save();
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
