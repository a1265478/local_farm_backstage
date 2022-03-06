import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/modules/dashboard/cubit/dashboard_cubit.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: List.generate(
          pageTitleList.length,
          (index) => BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return ListTile(
                selected: index == state.currentIndex,
                selectedTileColor: kNavBarBackgoundColor,
                title: Text(pageTitleList[index]),
                onTap: () {
                  BlocProvider.of<DashboardCubit>(context).navToIndex(index);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
