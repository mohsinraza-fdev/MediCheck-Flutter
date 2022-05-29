import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../models/appointment_model.dart';
import '../models/enums.dart';
import '../services/authentication_service.dart';

class ScheduleViewModel extends BaseViewModel {
  final authService = locator<AuthenticationService>();
  final navigator = locator<NavigationService>();

  List<Appointment> appointmentGiven = <Appointment>[];
  List<Appointment> appointmentTaken = <Appointment>[];

  Future<void> loadAppointments() async {
    setBusy(true);
    try {
      appointmentTaken = (await authService.getAppointmentsTaken())!;
      if (authService.userType == AccountType.doctor) {
        appointmentGiven = (await authService.getAppointmentsGiven())!;
      }
      setBusy(false);
    } catch (e) {
      setBusy(false);
    }
    setBusy(false);
  }

  String dateTimeToString(DateTime dateTime) {
    final dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    return dateFormat.format(dateTime);
  }

  cancelAppointmentGiven(Appointment appointment) async {
    setBusy(true);
    try {
      await authService.deleteAppointment(appointment.id);
      appointmentGiven.removeWhere((item) => item.id == appointment.id);
    } catch (e) {
      setBusy(false);
    }
    setBusy(false);
  }

  cancelAppointmentTaken(Appointment appointment) async {
    setBusy(true);
    try {
      await authService.deleteAppointment(appointment.id);
      appointmentTaken.removeWhere((item) => item.id == appointment.id);
    } catch (e) {
      setBusy(false);
    }
    setBusy(false);
  }
}
