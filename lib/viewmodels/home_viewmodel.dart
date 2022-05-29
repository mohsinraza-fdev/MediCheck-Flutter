import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.router.dart';
import '../app/locator.dart';
import '../models/enums.dart';
import '../services/authentication_service.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final authService = locator<AuthenticationService>();
  final navigator = locator<NavigationService>();

  AccountType get userType => authService.userType!;
  User get user => authService.user!;

  logout() async {
    setBusy(true);
    try {
      await Future.delayed(Duration(seconds: 1));
      await authService.logout();
      navigator.clearStackAndShow(Routes.loginView);
    } catch (e) {
      setBusy(false);
    }
  }

  showRequests() {
    int tabValue = 0;
    if (userType == AccountType.doctor) {
      tabValue = 2;
    } else {
      tabValue = 1;
    }
    navigator.navigateTo(Routes.requestView,
        arguments: RequestViewArguments(count: tabValue));
  }

  showAppointmentss() {
    int tabValue = 0;
    if (userType == AccountType.doctor) {
      tabValue = 2;
    } else {
      tabValue = 1;
    }
    navigator.navigateTo(Routes.scheduleView,
        arguments: ScheduleViewArguments(count: tabValue));
  }
}
