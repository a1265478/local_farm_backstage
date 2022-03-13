import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/modules/customer/cubit/custom_detail_cubit.dart';
import 'package:local_farm_backstage/modules/customer/model/customer.dart';
import 'package:local_farm_backstage/widgets/action_button.dart';
import 'package:local_farm_backstage/widgets/disable_action_button.dart';
import 'package:local_farm_backstage/widgets/update_result_snake_bar.dart';

class CustomDetailPage extends StatelessWidget {
  CustomDetailPage({
    Key? key,
    required this.customer,
    required this.customDetailCubit,
  }) : super(key: key);
  final CustomDetailCubit customDetailCubit;
  final Customer customer;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: customDetailCubit..assignEditCustomer(customer),
      child: BlocListener<CustomDetailCubit, CustomDetailState>(
        listener: (context, state) {
          if (state.uploadStatus == Status.success ||
              state.uploadStatus == Status.failure) {
            UpdateResultSnakeBar.show(context, result: state.uploadStatus);
            if (state.uploadStatus == Status.success) {
              Navigator.maybePop(context);
            }
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            padding: kPagePadding,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _form(),
                        const SizedBox(width: 10),
                        _imageList(),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: BlocBuilder<CustomDetailCubit, CustomDetailState>(
                        builder: (context, state) {
                          return state.uploadStatus == Status.working
                              ? const DisableActionButton()
                              : ActionButton(
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    customDetailCubit.save();
                                  },
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _form() => Flexible(
        child: BlocBuilder<CustomDetailCubit, CustomDetailState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: state.editCustomer.name,
                    decoration: const InputDecoration(
                      label: Text("名稱"),
                      enabledBorder: kEnableBorder,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      customDetailCubit.changeName(value);
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
                    initialValue: state.editCustomer.brandIntroduction,
                    maxLines: 11,
                    decoration: const InputDecoration(
                      label: Text("品牌介紹"),
                      enabledBorder: kEnableBorder,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      customDetailCubit.changeBrandIntroduction(value);
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
                    initialValue: state.editCustomer.designIntroduction,
                    maxLines: 11,
                    decoration: const InputDecoration(
                      label: Text("網頁設計案例介紹"),
                      enabledBorder: kEnableBorder,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      customDetailCubit.changeDesignIntroduction(value);
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
                    initialValue: state.editCustomer.webUrl,
                    decoration: const InputDecoration(
                      label: Text("客戶公司網址"),
                      enabledBorder: kEnableBorder,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      customDetailCubit.changeWebURL(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "內容不得為空";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      );

  Widget _imageList() => Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "圖片",
                  style: TextStyle(
                      fontSize: 16, color: Colors.black.withOpacity(0.6)),
                ),
                const SizedBox(width: 10),
                ActionButton(
                  title: "選擇檔案",
                  onPressed: () {
                    customDetailCubit.appendImage();
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            BlocBuilder<CustomDetailCubit, CustomDetailState>(
              buildWhen: (previous, current) =>
                  previous.editCustomer.imageList !=
                  current.editCustomer.imageList,
              builder: (context, state) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.editCustomer.imageList.length,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Stack(
                      children: [
                        Image.memory(
                          base64Decode(
                            state.editCustomer.imageList[index],
                          ),
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: IconButton(
                            onPressed: () {
                              customDetailCubit.removeImage(index);
                            },
                            icon: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
}
