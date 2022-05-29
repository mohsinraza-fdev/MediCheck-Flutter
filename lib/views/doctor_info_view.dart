import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../models/enums.dart';
import '../viewmodels/doctor_info_viewmodel.dart';

class DoctorInfoView extends StatelessWidget {
  const DoctorInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoctorInfoViewModel>.reactive(
      viewModelBuilder: () => DoctorInfoViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: appBackground,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              height: 155,
              color: appYellow,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 5, color: appBackground),
                      ),
                      child: FittedBox(
                        child: const Icon(
                          Icons.person,
                          color: appBackground,
                        ),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.currentDoctor!.name!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: appBackground,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              model.currentDoctor!.specialization!.join(', '),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: appBackground,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Description:',
                          style: TextStyle(
                              color: appYellow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          model.currentDoctor!.description!,
                          style: TextStyle(
                              color: appYellow,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Experience:',
                          style: TextStyle(
                              color: appYellow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          model.currentDoctor!.experience!.toString() +
                              ' yr(s)',
                          style: TextStyle(
                              color: appYellow,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Available Locations:',
                          style: TextStyle(
                              color: appYellow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...List.generate(
                        model.currentDoctor!.locations!.length,
                        (index) => GestureDetector(
                          onTap: () => model.selectedLocation = index,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            margin: const EdgeInsets.only(top: 15),
                            height: 80,
                            decoration: BoxDecoration(
                              color: model.selectedLocation == index
                                  ? appYellow
                                  : appBackground,
                              border: Border.all(width: 5, color: appYellow),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.currentDoctor!.locations![index].name!,
                                  style: TextStyle(
                                    color: model.selectedLocation == index
                                        ? appBackground
                                        : appYellow,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  model.currentDoctor!.locations![index].timing!
                                          .from! +
                                      ' - ' +
                                      model.currentDoctor!.locations![index]
                                          .timing!.to! +
                                      '  (' +
                                      model.currentDoctor!.locations![index]
                                          .days!
                                          .join(', ') +
                                      ')',
                                  style: TextStyle(
                                    color: model.selectedLocation == index
                                        ? appBackground
                                        : appYellow,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 1.5,
              color: appYellow,
            ),
            Row(
              children: [
                if (model.currentDoctor!.doctorType ==
                    DoctorType.registered) ...[
                  const SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (model.isBusy) {
                        } else {
                          bool? verify = await model.verifyAppointment();
                          if (verify == null) {
                            AwesomeDialog(
                                headerAnimationLoop: false,
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.SCALE,
                                title: 'Connection Error',
                                desc: 'Please check your internet connection',
                                btnOkOnPress: () {},
                                btnOkColor: Colors.red,
                                btnOkIcon: Icons.cancel)
                              ..show();
                          } else if (verify == true) {
                            AwesomeDialog(
                              headerAnimationLoop: false,
                              context: context,
                              dialogType: DialogType.WARNING,
                              animType: AnimType.SCALE,
                              title: 'Appointment Overlap',
                              desc:
                                  'You can only make 1 appointment at a time with a doctor',
                              btnOkOnPress: () {},
                            )..show();
                          } else {
                            bool? value = await model.getAppointment();
                            if (value == null) {
                              AwesomeDialog(
                                  headerAnimationLoop: false,
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.SCALE,
                                  title: 'Are you Drunk?',
                                  desc:
                                      'You dont need to get an appointment with yourself',
                                  btnOkOnPress: () {},
                                  btnOkColor: Colors.red,
                                  btnOkIcon: Icons.cancel)
                                ..show();
                            } else if (value == true) {
                              AwesomeDialog(
                                headerAnimationLoop: false,
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.SCALE,
                                title: 'Success',
                                desc: 'Appointment request sent',
                                btnOkOnPress: () {},
                              )..show();
                            } else {
                              AwesomeDialog(
                                  headerAnimationLoop: false,
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.SCALE,
                                  title: 'Connection Error',
                                  desc: 'Please check your internet connection',
                                  btnOkOnPress: () {},
                                  btnOkColor: Colors.red,
                                  btnOkIcon: Icons.cancel)
                                ..show();
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: appYellow,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                        child: model.isBusy
                            ? const CircularProgressIndicator(
                                color: appBackground,
                              )
                            : const Text(
                                'Get Appointment',
                                style: TextStyle(
                                    color: appBackground,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () => model.openMaps(),
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: appYellow,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Get Directions',
                        style: TextStyle(
                            color: appBackground,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}
