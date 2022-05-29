import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.router.dart';
import '../app/colors.dart';
import '../app/locator.dart';
import '../models/enums.dart';
import '../services/authentication_service.dart';

class SignupViewModel extends FormViewModel {
  final authService = locator<AuthenticationService>();
  final navigator = locator<NavigationService>();

  AccountType get accountType => authService.accountType;

  void selectPatient() {
    authService.accountType = AccountType.patient;
    authService.doctorInfo = null;
    notifyListeners();
  }

  void selectDoctor() {
    navigator.navigateTo(Routes.doctorFormView)?.then((value) {
      notifyListeners();
    });
  }

  void navigateToLogin() {
    navigator.clearStackAndShow(Routes.loginView);
  }

  void validateAndSignUp(BuildContext context) async {
    setBusy(true);
    notifyListeners();
    if (formValueMap['name'] == '' ||
        formValueMap['email'] == '' ||
        formValueMap['password'] == '' ||
        formValueMap['confirmPassword'] == '') {
      setValidationMessage('Please fill all fields');
    } else if (!EmailValidator.validate(formValueMap['email'])) {
      setValidationMessage('Please enter a valid email');
    } else if (formValueMap['password'].length < 8) {
      setValidationMessage('Password is less than 8 characters');
    } else if (formValueMap['password'] != formValueMap['confirmPassword']) {
      setValidationMessage('Passwords do not match');
    } else {
      try {
        await authService.signUp(formValueMap['email'],
            formValueMap['password'], formValueMap['name']);
        setBusy(false);
        notifyListeners();
        var snackBar = SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.none,
            content: AwesomeSnackbarContent(
                color: appLightBlue,
                title: 'Registration Complete',
                message: 'Successfully registered as a ${accountType.name}',
                contentType: ContentType.success));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        navigator.clearStackAndShow(Routes.homeView);
      } catch (e) {
        setValidationMessage('Email already exists');
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
