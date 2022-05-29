import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../viewmodels/schedule_viewmodel.dart';

class ScheduleView extends HookWidget {
  final int count;
  const ScheduleView({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = useTabController(initialLength: count);
    return ViewModelBuilder<ScheduleViewModel>.reactive(
      viewModelBuilder: () => ScheduleViewModel(),
      onModelReady: (viewModel) => viewModel.loadAppointments(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: appBackground,
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: appYellow,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 70),
                  const Text(
                    'Appointments',
                    style: TextStyle(
                        color: appGreen,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: appGreen, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.3))
              ]),
              child: TabBar(
                controller: tabcontroller,
                indicatorColor: appYellow,
                tabs: [
                  Tab(
                    child: Center(
                      child: Text(
                        'Given',
                        style: TextStyle(color: appYellow, fontSize: 15),
                      ),
                    ),
                  ),
                  if (count == 2)
                    Tab(
                      child: Center(
                        child: Text(
                          'Taken',
                          style: TextStyle(color: appYellow, fontSize: 15),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  if (count == 2)
                    model.isBusy
                        ? const SpinKitSpinningLines(
                            size: 100,
                            color: appYellow,
                            lineWidth: 3,
                            duration: Duration(milliseconds: 1500),
                          )
                        : RefreshIndicator(
                            onRefresh: () => model.loadAppointments(),
                            backgroundColor: appYellow,
                            color: appBackground,
                            child: ListView(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              children: List.generate(
                                model.appointmentGiven.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: appYellow))),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      onTap: () {},
                                      title: Text(
                                        model.appointmentGiven[index].fromName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: appYellow,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 19),
                                      ),
                                      subtitle: Text(
                                        'Date: ' +
                                            model
                                                .dateTimeToString(model
                                                    .appointmentGiven[index]
                                                    .dateTime)
                                                .split(' ')[0] +
                                            "  Time: " +
                                            model
                                                .dateTimeToString(model
                                                    .appointmentGiven[index]
                                                    .dateTime)
                                                .split(" ")[1],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: appYellow,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          AwesomeDialog(
                                              headerAnimationLoop: false,
                                              context: context,
                                              dialogType: DialogType.ERROR,
                                              animType: AnimType.SCALE,
                                              title: 'Are you sure?',
                                              desc:
                                                  'Scheduled Appointment will be canceled',
                                              btnOkText: 'Confirm',
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () => model
                                                  .cancelAppointmentGiven(model
                                                      .appointmentGiven[index]))
                                            ..show();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: appBlue,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  model.isBusy
                      ? const SpinKitSpinningLines(
                          size: 100,
                          color: appYellow,
                          lineWidth: 3,
                          duration: Duration(milliseconds: 1500),
                        )
                      : RefreshIndicator(
                          onRefresh: () => model.loadAppointments(),
                          backgroundColor: appYellow,
                          color: appBackground,
                          child: ListView(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            children: List.generate(
                                model.appointmentTaken.length,
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: appYellow))),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          onTap: () {},
                                          title: Text(
                                            model.appointmentTaken[index]
                                                .fromName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: appYellow,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 19),
                                          ),
                                          subtitle: Text(
                                            'Date: ' +
                                                model
                                                    .dateTimeToString(model
                                                        .appointmentTaken[index]
                                                        .dateTime)
                                                    .split(' ')[0] +
                                                "  Time: " +
                                                model
                                                    .dateTimeToString(model
                                                        .appointmentTaken[index]
                                                        .dateTime)
                                                    .split(" ")[1],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: appYellow,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                          ),
                                          trailing: GestureDetector(
                                            onTap: () {
                                              AwesomeDialog(
                                                  headerAnimationLoop: false,
                                                  context: context,
                                                  dialogType: DialogType.ERROR,
                                                  animType: AnimType.SCALE,
                                                  title: 'Are you sure?',
                                                  desc:
                                                      'cheduled Appointment will be canceled',
                                                  btnOkText: 'Confirm',
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () => model
                                                      .cancelAppointmentTaken(
                                                          model.appointmentTaken[
                                                              index]))
                                                ..show();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 25,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: appBlue,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.4),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                ],
                controller: tabcontroller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
