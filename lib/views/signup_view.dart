import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../app/constants.dart';
import '../models/enums.dart';
import '../viewmodels/signup_viewmodel.dart';

class SignupView extends HookWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = useTextEditingController();
    TextEditingController email = useTextEditingController();
    TextEditingController password = useTextEditingController();
    TextEditingController confirmPassword = useTextEditingController();
    FocusNode focus1 = useFocusNode();
    FocusNode focus2 = useFocusNode();
    FocusNode focus3 = useFocusNode();
    FocusNode focus4 = useFocusNode();

    void _fireFormChanged(SignupViewModel viewModel) {
      viewModel.setData({
        "name": name.text,
        "email": email.text,
        "password": password.text,
        "confirmPassword": confirmPassword.text,
      });
    }

    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      onModelReady: (viewModel) => viewModel.setData({
        "name": name.text,
        "email": email.text,
        "password": password.text,
        "confirmPassword": confirmPassword.text,
      }),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: appBackground,
          body: model.isBusy
              ? const SpinKitSpinningLines(
                  size: 100,
                  color: appYellow,
                  lineWidth: 3,
                  duration: Duration(milliseconds: 1500),
                )
              : SingleChildScrollView(
                  child: SizedBox(
                    height: screenHeight(context),
                    width: screenWidth(context),
                    child: Column(
                      children: [
                        const SizedBox(height: 70),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: const Text(
                              'Let\'s quickly sign you up!',
                              style: TextStyle(
                                  color: appYellow,
                                  fontSize: 44,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: Row(
                            children: [
                              Text(
                                'Account Type',
                                style: TextStyle(
                                    color: appYellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              const Spacer(),
                              Container(
                                height: 30,
                                width: 230,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: appYellow, width: 1),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => model.selectPatient(),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: model.accountType ==
                                                    AccountType.patient
                                                ? appYellow
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.horizontal(
                                              left: Radius.circular(45),
                                            ),
                                          ),
                                          child: Text(
                                            'Patient',
                                            style: TextStyle(
                                              color: model.accountType ==
                                                      AccountType.patient
                                                  ? appBackground
                                                  : appYellow,
                                              fontSize: 15,
                                              fontWeight: model.accountType ==
                                                      AccountType.patient
                                                  ? FontWeight.w800
                                                  : FontWeight.w400,
                                              letterSpacing: 0.7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => model.selectDoctor(),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: model.accountType ==
                                                    AccountType.doctor
                                                ? appYellow
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.horizontal(
                                              right: Radius.circular(45),
                                            ),
                                          ),
                                          child: Text(
                                            'Doctor',
                                            style: TextStyle(
                                              color: model.accountType ==
                                                      AccountType.doctor
                                                  ? appBackground
                                                  : appYellow,
                                              fontSize: 15,
                                              fontWeight: model.accountType ==
                                                      AccountType.doctor
                                                  ? FontWeight.w800
                                                  : FontWeight.w400,
                                              letterSpacing: 0.7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: appYellow),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: name,
                            focusNode: focus1,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              color: appYellow,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 1,
                            onChanged: (text) {
                              _fireFormChanged(model);
                            },
                            onSubmitted: (text) {
                              FocusScope.of(context).requestFocus(focus2);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: appYellow),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: email,
                            focusNode: focus2,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              color: appYellow,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 1,
                            onChanged: (text) {
                              _fireFormChanged(model);
                            },
                            onSubmitted: (text) {
                              FocusScope.of(context).requestFocus(focus3);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: appYellow),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: password,
                            focusNode: focus3,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              color: appYellow,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                            obscureText: true,
                            maxLines: 1,
                            onChanged: (text) {
                              _fireFormChanged(model);
                            },
                            onSubmitted: (text) {
                              FocusScope.of(context).requestFocus(focus4);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: appYellow),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: confirmPassword,
                            focusNode: focus4,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              color: appYellow,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                            obscureText: true,
                            maxLines: 1,
                            onChanged: (text) {
                              _fireFormChanged(model);
                            },
                            onSubmitted: (text) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          alignment: Alignment.center,
                          height: 17,
                          child: FittedBox(
                            child: Text(
                              model.validationMessage ?? ' ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 216, 97, 89)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.topCenter,
                          child: RichText(
                              text: TextSpan(
                            text: 'Already have an account ?  ',
                            style: TextStyle(
                                color: appBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    model.navigateToLogin();
                                  },
                              ),
                            ],
                          )),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            model.validateAndSignUp(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 52,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: appYellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: appBackground,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
