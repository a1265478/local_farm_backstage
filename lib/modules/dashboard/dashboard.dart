import 'package:flutter/material.dart';
import 'package:local_farm_backstage/const/const.dart';
import 'package:local_farm_backstage/core/firebase_repository.dart';
import 'package:local_farm_backstage/modules/banners/banners.dart';

import 'package:local_farm_backstage/modules/introduction/introduction_page.dart';
import 'package:local_farm_backstage/modules/line_content/line_content_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: kPrimaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      pageTitleList.length,
                      (index) => ListTile(
                        selected: index == _currentPage,
                        title: Text(pageTitleList[index]),
                        onTap: () {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: FutureBuilder<bool>(
                  future: FirebaseRepository().isSyncDataFromFirebase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.topCenter,
                              child: Text(pageTitleList[_currentPage],
                                  style: kHeaderTextStyle),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: IndexedStack(
                                  index: _currentPage,
                                  children: [
                                    IntroductionPage(),
                                    const Banners(),
                                    LineContentPage(),
                                    Text("3"),
                                    Text("5"),
                                    Text("6"),
                                  ],
                                )),
                          ],
                        ),
                      );
                    }
                    return const Center(
                        child: const CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
