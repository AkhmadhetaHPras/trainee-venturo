import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/routes/main_route.dart';
import '../../modules/global_controllers/bottom_navigation_controller.dart';

class BottomNavigationObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    updateActiveIndex();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    updateActiveIndex();
  }

  void updateActiveIndex() {
    if (BottomNavigationController.to != null) {
      final currentRoute = Get.currentRoute;

      if (currentRoute == MainRoute.list) {
        BottomNavigationController.to.setActiveIndex(0);
      } else if (currentRoute == MainRoute.order) {
        BottomNavigationController.to.setActiveIndex(1);
      } else if (currentRoute == MainRoute.profile) {
        BottomNavigationController.to.setActiveIndex(2);
      }
    }
  }
}
