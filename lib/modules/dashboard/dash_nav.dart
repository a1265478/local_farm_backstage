import 'package:flutter/material.dart';
import 'package:local_farm_backstage/modules/banners/banners.dart';
import 'package:local_farm_backstage/modules/introduction/introduction_page.dart';
import 'package:local_farm_backstage/modules/line_content/line_content_page.dart';

class DashNav extends StatelessWidget {
  const DashNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        // MaterialPage(child: LineContentPage()),
        // MaterialPage(child: Banners()),
        MaterialPage(child: IntroductionPage()),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}
