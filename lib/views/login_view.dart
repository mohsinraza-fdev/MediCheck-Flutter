import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../app/constants.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = useTextEditingController();
    TextEditingController password = useTextEditingController();
    FocusNode focus1 = useFocusNode();
    FocusNode focus2 = useFocusNode();

    void _fireFormChanged(LoginViewModel viewModel) {
      viewModel.setData({
        "email": email.text,
        "password": password.text,
      });
    }

    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (viewModel) => viewModel.setData({
        "email": email.text,
        "password": password.text,
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.health_and_safety,
                                color: appYellow,
                                size: 150,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Medi Check',
                                style: TextStyle(
                                    color: appYellow,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: appYellow),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: email,
                            focusNode: focus1,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
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
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: appYellow,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
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
                            focusNode: focus2,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                            maxLines: 1,
                            obscureText: true,
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
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: appYellow,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
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
                            text: 'Don\'t have an account ?  ',
                            style: TextStyle(
                                color: appBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    model.navigateToSignUp();
                                  },
                              ),
                            ],
                          )),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            model.validateAndLogin();
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
                              'Login',
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
