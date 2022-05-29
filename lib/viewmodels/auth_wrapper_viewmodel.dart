import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.router.dart';
import '../app/locator.dart';
import '../services/authentication_service.dart';

class AuthWrapperViewModel extends BaseViewModel {
  final authService = locator<AuthenticationService>();
  final navigator = locator<NavigationService>();

  checkAuthentication() async {
    setError(null);
    setBusy(true);
    notifyListeners();
    try {
      await authService.initialize();
      setBusy(false);
      notifyListeners();
      navigator.clearStackAndShow(Routes.homeView);
    } catch (e) {
      if (e.toString() == 'null user') {
        navigator.clearStackAndShow(Routes.loginView);
      } else {
        setError('Something went wrong');
      }
    }
    setBusy(false);
    notifyListeners();
  }
}
