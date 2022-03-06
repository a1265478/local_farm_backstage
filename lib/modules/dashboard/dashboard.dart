import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/core/firebase_repository.dart';
import 'package:local_farm_backstage/modules/banners/banners.dart';
import 'package:local_farm_backstage/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:local_farm_backstage/modules/dashboard/dash_nav.dart';
import 'package:local_farm_backstage/modules/dashboard/my_drawer.dart';

import 'package:local_farm_backstage/modules/introduction/introduction_page.dart';
import 'package:local_farm_backstage/modules/line_content/line_content_page.dart';
import 'package:local_farm_backstage/modules/service/service_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentPage = 0;
  PageController controller = PageController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: Scaffold(
        key: scaffoldKey,
        drawer: MyDrawer(),
        drawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
        ),
        body: FutureBuilder<bool>(
            future: FirebaseRepository().isSyncDataFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!) {
                return BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    return Scaffold(
                      body: Navigator(
                        pages: [
                          if (state.currentIndex == 0)
                            MaterialPage(child: IntroductionPage()),
                          if (state.currentIndex == 1)
                            const MaterialPage(child: Banners()),
                          if (state.currentIndex == 2)
                            const MaterialPage(child: LineContentPage()),
                          if (state.currentIndex == 3)
                            MaterialPage(child: ServicePage()),
                        ],
                        onPopPage: (route, result) => route.didPop(result),
                      ),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
