import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/modules/service/cubit/service_cubit.dart';
import 'package:local_farm_backstage/modules/service/model/service.dart';
import 'package:local_farm_backstage/widgets/action_button.dart';

import 'components/type_radio_button.dart';

class ServiceEditor extends StatelessWidget {
  ServiceEditor({
    Key? key,
    this.service = Service.empty,
    required this.serviceCubit,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final Service service;
  final ServiceCubit serviceCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceCubit..setEditService(service),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.maybePop(context);
                  serviceCubit.setEditService(Service.empty);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: kDarkGreenColor,
                                  width: 2,
                                )),
                            child: Row(
                              children: [
                                Text(
                                  "類型：",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                TypeRadioButton(
                                  isSelected: state.editService.type == "LINE",
                                  type: "LINE",
                                  onTap: () {
                                    serviceCubit.updateServiceType("LINE");
                                  },
                                ),
                                TypeRadioButton(
                                  isSelected: state.editService.type == "Web",
                                  type: "Web",
                                  onTap: () {
                                    serviceCubit.updateServiceType("Web");
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: state.editService.title,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "標題不得為空";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("標題"),
                              enabledBorder: kEnableBorder,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              serviceCubit.updateServiceTitle(value);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            maxLines: 11,
                            initialValue: state.editService.content,
                            decoration: const InputDecoration(
                              label: Text("內容"),
                              enabledBorder: kEnableBorder,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              serviceCubit.updateServiceContent(value);
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
                            initialValue: state.editService.price.toString(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "價錢不得為空";
                              }

                              if (int.tryParse(value) == null) {
                                return "價錢格式錯誤";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text("價錢"),
                              enabledBorder: kEnableBorder,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              serviceCubit.updateServicePrice(value);
                            },
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerRight,
                            child: ActionButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;
                                serviceCubit.submitService();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
