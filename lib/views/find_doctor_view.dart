import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../models/enums.dart';
import '../viewmodels/find_doctor_viewmodel.dart';
import 'doctor_info_view.dart';

class FindDoctorView extends StatelessWidget {
  String? specialization;

  FindDoctorView({Key? key, this.specialization}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FindDoctorViewModel>.reactive(
      viewModelBuilder: () => FindDoctorViewModel(),
      onModelReady: (viewModel) => viewModel.loadDoctors(specialization),
      onDispose: (viewModel) => viewModel.onDispose(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          if (model.searchBarController.text != '') {
            model.reset();
            FocusManager.instance.primaryFocus?.unfocus();
            return false;
          } else {
            return true;
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: appBackground,
            body: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: appYellow,
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1.2))),
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      const Text(
                        'Find Doctor',
                        style: TextStyle(
                            color: appBackground,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                AnimatedContainer(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  duration: Duration(milliseconds: 10),
                  height: 40,
                  decoration: BoxDecoration(
                    color: appYellowLight.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: appBackground),
                    maxLines: 1,
                    textInputAction: TextInputAction.search,
                    controller: model.searchBarController,
                    onChanged: (text) {
                      model.filter();
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: appBackground,
                      ),
                      suffixIconColor: appBackground,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: appBackground,
                      ),
                      isCollapsed: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                  ),
                ),
                Container(
                  color: appYellow,
                  height: 1,
                ),
                Expanded(
                  child: model.isLoading
                      ? const SpinKitSpinningLines(
                          size: 100,
                          color: appYellow,
                          lineWidth: 3,
                          duration: Duration(milliseconds: 1500),
                        )
                      : model.allDoctors.isEmpty
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'No data found',
                                  style:
                                      TextStyle(color: appYellow, fontSize: 16),
                                ),
                              ),
                            )
                          : (model.searchBarController.text != '' &&
                                  model.doctors.isEmpty)
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      'No match found',
                                      style: TextStyle(
                                          color: appYellow, fontSize: 16),
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                        model.doctors.length,
                                        (index) => GestureDetector(
                                          onTap: () {
                                            model.setInfoDoctor(
                                                model.doctors[index]);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const DoctorInfoView()));
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: 95,
                                            margin: const EdgeInsets.only(
                                                top: 15, left: 15, right: 15),
                                            decoration: BoxDecoration(
                                              color: model.doctors[index]
                                                          .doctorType ==
                                                      DoctorType.normal
                                                  ? appYellow
                                                  : appBlueExclusive,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 1,
                                                  offset: const Offset(0, 1),
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          model.doctors[index]
                                                              .name!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                appBackground,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          model.doctors[index]
                                                              .specialization!
                                                              .join(', '),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                appBackground,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          'Experience: ' +
                                                              model
                                                                  .doctors[
                                                                      index]
                                                                  .experience!
                                                                  .toString() +
                                                              ' yr(s)',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                appBackground,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (specialization != null)
                                                    Text(
                                                      '  ' +
                                                          model.doctors[index]
                                                              .distance
                                                              .toString() +
                                                          ' Km',
                                                      style: TextStyle(
                                                          color: appBackground,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
