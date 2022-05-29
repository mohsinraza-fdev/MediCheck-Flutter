import 'package:email_validator/email_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.router.dart';
import '../app/locator.dart';
import '../services/authentication_service.dart';

class LoginViewModel extends FormViewModel {
  final authService = locator<AuthenticationService>();
  final navigator = locator<NavigationService>();

  navigateToSignUp() {
    navigator.navigateTo(Routes.signupView);
  }

  Future<void> validateAndLogin() async {
    setBusy(true);
    notifyListeners();
    if (formValueMap['email'] == '' || formValueMap['password'] == '') {
      setValidationMessage('Please fill all fields');
    } else if (!EmailValidator.validate(formValueMap['email'])) {
      setValidationMessage('Please enter a valid email');
    } else {
      try {
        await authService.login(
            formValueMap['email'], formValueMap['password']);
        setBusy(false);
        notifyListeners();
        navigator.clearStackAndShow(Routes.homeView);
      } catch (e) {
        setValidationMessage('Incorrect email or password');
      }
    }
    setBusy(false);
    notifyListeners();
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
