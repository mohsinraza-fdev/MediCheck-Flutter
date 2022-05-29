import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../viewmodels/request_viewmodel.dart';

class RequestView extends HookWidget {
  final int count;

  const RequestView({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = useTabController(initialLength: count);
    return ViewModelBuilder<RequestViewModel>.reactive(
      viewModelBuilder: () => RequestViewModel(),
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
                    'Requests',
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
                        'Sent',
                        style: TextStyle(color: appYellow, fontSize: 15),
                      ),
                    ),
                  ),
                  if (count == 2)
                    Tab(
                      child: Center(
                        child: Text(
                          'Recieved',
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
                                model.requestSent.length,
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
                                            model.requestSent[index].toName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: appYellow,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19),
                                          ),
                                          subtitle: Text(
                                            model.requestSent[index]
                                                .toSpecializations,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: appYellow,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
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
                                                      'Appointment request will be canceled',
                                                  btnOkText: 'Confirm',
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () => model
                                                      .cancelAppointment(model
                                                          .requestSent[index]))
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
                                  model.requestReceived.length,
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
                                              model.requestReceived[index]
                                                  .fromName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: appYellow,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 19),
                                            ),
                                            subtitle: Text(
                                              'Status: Pending Approval',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: appYellow,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                            trailing: GestureDetector(
                                              onTap: () {
                                                dynamic dialog = AwesomeDialog(
                                                  headerAnimationLoop: false,
                                                  context: context,
                                                  dialogType:
                                                      DialogType.QUESTION,
                                                  animType: AnimType.SCALE,
                                                  title: 'Appointment Request',
                                                  desc:
                                                      'How would you like to respond to the appointment request of ${model.requestReceived[index].fromName}',
                                                  btnCancelText: 'Reject',
                                                  btnCancelOnPress: () {
                                                    model.rejectAppointment(
                                                        model.requestReceived[
                                                            index]);
                                                  },
                                                  btnOkText: 'Accept',
                                                  btnOkOnPress: () {
                                                    DatePicker
                                                        .showDateTimePicker(
                                                      context,
                                                      onConfirm:
                                                          (dateTime) async {
                                                        bool accepted = await model
                                                            .acceptAppointment(
                                                                dateTime,
                                                                model.requestReceived[
                                                                    index]);
                                                        if (accepted == true) {
                                                          var snackBar = SnackBar(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              elevation: 0,
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              dismissDirection:
                                                                  DismissDirection
                                                                      .none,
                                                              content: AwesomeSnackbarContent(
                                                                  color:
                                                                      appYellow,
                                                                  title:
                                                                      'Appointment Scheduled',
                                                                  message:
                                                                      'Appointment for a new patient was added to your schedule',
                                                                  contentType:
                                                                      ContentType
                                                                          .success));
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        }
                                                      },
                                                    );
                                                  },
                                                )..show();
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
                                                  'Respond',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
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
