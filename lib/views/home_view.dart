import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicheck/views/prediction_view.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../models/enums.dart';
import '../viewmodels/home_viewmodel.dart';
import 'find_doctor_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: appBackground,
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 16,
          unselectedFontSize: 15,
          iconSize: 30,
          elevation: 20,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: appLightBlue,
          selectedItemColor: appYellow,
          type: BottomNavigationBarType.fixed,
          backgroundColor: appNavBackground,
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: 'Prediction'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_search_rounded), label: 'Find Doctor')
          ],
        ),
        body: getViewForIndex(model.currentIndex),
      ),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return PredictionView();
      case 2:
        return FindDoctorView();
      default:
        return HomeScreen();
    }
  }
}

class HomeScreen extends ViewModelWidget<HomeViewModel> {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: appBackground,
      body: viewModel.isBusy
          ? const SpinKitSpinningLines(
              size: 100,
              color: appYellow,
              lineWidth: 3,
              duration: Duration(milliseconds: 1500),
            )
          : Column(
              children: [
                const SizedBox(height: 65),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        margin: const EdgeInsets.only(left: 14),
                        color: Colors.transparent,
                        child: Icon(
                          Icons.menu_sharp,
                          color: appYellow,
                          size: 40,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => viewModel.logout(),
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 35,
                          decoration: BoxDecoration(
                            color: appYellow,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Logout',
                                style: TextStyle(
                                    color: appGreen,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.logout,
                                color: appGreen,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Hello ' +
                          (viewModel.userType == AccountType.doctor
                              ? 'Doc'
                              : (viewModel.user.displayName ?? 'Sir')) +
                          '!\nHow are you feeling today.',
                      style: TextStyle(
                          color: appYellow,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          height: 1.3),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: appYellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: appBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Space reserved for Ads',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appYellow,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GridView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 20),
                  children: [
                    GestureDetector(
                      onTap: () => viewModel.showRequests(),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appYellow,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.beenhere_rounded,
                              color: appBackground,
                              size: 60,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Appointment Requests',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: appGreen,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => viewModel.showAppointmentss(),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appYellow,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_moderator_sharp,
                              color: appBackground,
                              size: 60,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Appointment Schedule',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: appGreen,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 20),
                //     child: Text(
                //       'Spotlight',
                //       style: TextStyle(
                //           color: appYellow,
                //           fontSize: 18,
                //           fontWeight: FontWeight.w500,
                //           height: 1.3),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 15),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       ...List.generate(
                //         5,
                //         (index) => Container(
                //           height: 150,
                //           width: 120,
                //           alignment: Alignment.center,
                //           margin: const EdgeInsets.only(left: 20),
                //           decoration: BoxDecoration(
                //             color: appYellow,
                //             borderRadius: BorderRadius.circular(15),
                //           ),
                //           child: Container(
                //             alignment: Alignment.center,
                //             margin: const EdgeInsets.symmetric(
                //                 horizontal: 2, vertical: 2),
                //             decoration: BoxDecoration(
                //               color: appBackground,
                //               borderRadius: BorderRadius.circular(15),
                //             ),
                //             child: const Text(
                //               'Featured\nDoctor',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: appYellow,
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(width: 20),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 20),
              ],
            ),
    );
  }
}
