import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/modules/customer/cubit/custom_detail_cubit.dart';
import 'package:local_farm_backstage/modules/customer/custom_detail_page.dart';
import 'package:local_farm_backstage/modules/customer/model/customer.dart';
import 'package:local_farm_backstage/util/uikit.dart';

class CustomListPage extends StatelessWidget {
  CustomListPage({Key? key}) : super(key: key);
  final CustomDetailCubit customDetailCubit = CustomDetailCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => customDetailCubit..loadList(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  navigatorToEditor(context);
                },
                icon: const Icon(Icons.add),
                tooltip: "新增項目",
              ),
              const Divider(thickness: 3),
              BlocBuilder<CustomDetailCubit, CustomDetailState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.customerList.length,
                    itemBuilder: (_, index) => ListTile(
                      onTap: () {},
                      title: Text(state.customerList[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              navigatorToEditor(
                                context,
                                customer: state.customerList[index],
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              customDetailCubit
                                  .delete(state.customerList[index].id);
                            },
                          ),
                        ],
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

  void navigatorToEditor(BuildContext context, {Customer? customer}) {
    UiKit.slideTransition(
      context,
      CustomDetailPage(
        customDetailCubit: customDetailCubit,
        customer: customer ?? Customer.empty,
      ),
    );
  }
}
