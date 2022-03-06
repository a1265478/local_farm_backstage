import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/core/enumKey.dart';
import 'package:local_farm_backstage/modules/service/components/service_list_tile.dart';
import 'package:local_farm_backstage/modules/service/cubit/service_cubit.dart';
import 'package:local_farm_backstage/modules/service/service_editor.dart';
import 'package:local_farm_backstage/widgets/update_result_snake_bar.dart';

import 'model/service.dart';

class ServicePage extends StatelessWidget {
  ServicePage({Key? key}) : super(key: key);
  final ServiceCubit serviceCubit = ServiceCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceCubit..loadServiceList(),
      child: Scaffold(
        body: BlocListener<ServiceCubit, ServiceState>(
          listener: (context, state) {
            if (state.saveStatus == Status.success ||
                state.saveStatus == Status.failure) {
              UpdateResultSnakeBar.show(context, result: state.saveStatus);
              if (state.saveStatus == Status.success) {
                Navigator.maybePop(context);
              }
            }
            // TODO: implement listener
          },
          child: SingleChildScrollView(
            padding: kPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: "新增服務項目",
                  onPressed: () {
                    Navigator.of(context).push(_createRoute());
                  },
                ),
                BlocBuilder<ServiceCubit, ServiceState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        const SizedBox(height: 20.0),
                        ExpansionTile(
                          title: const Text(
                            "LINE",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          children: [
                            ...state.serviceList
                                .where((element) => element.type == "LINE")
                                .toList()
                                .map(
                                  (e) => ServiceListTile(
                                    service: e,
                                    onEdit: () {
                                      Navigator.of(context)
                                          .push(_createRoute(service: e));
                                    },
                                    onDelete: () {
                                      serviceCubit.deleteService(e.id);
                                    },
                                  ),
                                ),
                          ],
                        ),
                        ExpansionTile(
                          title: const Text(
                            "Web",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          children: [
                            ...state.serviceList
                                .where((element) => element.type == "Web")
                                .toList()
                                .map(
                                  (e) => ServiceListTile(
                                    service: e,
                                    onEdit: () {
                                      Navigator.of(context)
                                          .push(_createRoute(service: e));
                                    },
                                    onDelete: () {
                                      serviceCubit.deleteService(e.id);
                                    },
                                  ),
                                ),
                          ],
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

  Route _createRoute({Service? service}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ServiceEditor(
        serviceCubit: serviceCubit,
        service: service ?? Service.empty,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
