import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../viewmodels/auth_wrapper_viewmodel.dart';

class AuthWrapperView extends StatelessWidget {
  const AuthWrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthWrapperViewModel>.reactive(
      viewModelBuilder: () => AuthWrapperViewModel(),
      onModelReady: (viewModel) => viewModel.checkAuthentication(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: appBackground,
        body: Container(
          alignment: Alignment.center,
          child: model.modelError != null
              ? Text(
                  model.modelError,
                  style: const TextStyle(
                      color: appYellow,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              : model.isBusy
                  ? const SpinKitSpinningLines(
                      size: 100,
                      color: appYellow,
                      lineWidth: 3,
                      duration: Duration(milliseconds: 1500),
                    )
                  : const Center(),
        ),
      ),
    );
  }
}
