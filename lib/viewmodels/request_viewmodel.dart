import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../models/appointment_model.dart';
import '../models/enums.dart';
import '../services/authentication_service.dart';

class RequestViewModel extends BaseViewModel {
  final authService = locator<AuthenticationService>();
  final navigator = locator<NavigationService>();

  List<Appointment> requestSent = <Appointment>[];
  List<Appointment> requestReceived = <Appointment>[];

  Future<void> loadAppointments() async {
    setBusy(true);
    try {
      requestSent = (await authService.getRequestedAppointments())!;
      if (authService.userType == AccountType.doctor) {
        requestReceived = (await authService.getAppointmentRequests())!;
      }
      setBusy(false);
    } catch (e) {
      setBusy(false);
    }
    setBusy(false);
  }

  cancelAppointment(Appointment appointment) async {
    setBusy(true);
    try {
      await authService.deleteAppointment(appointment.id);
      requestSent.removeWhere((item) => item.id == appointment.id);
    } catch (e) {
      setBusy(false);
    }
    setBusy(false);
  }

  rejectAppointment(Appointment appointment) async {
    setBusy(true);
    try {
      await authService.deleteAppointment(appointment.id);
      requestReceived.removeWhere((item) => item.id == appointment.id);
    } catch (e) {
      setBusy(false);
    }
    setBusy(false);
  }

  Future<bool> acceptAppointment(
      DateTime dateTime, Appointment appointment) async {
    setBusy(true);
    try {
      await authService.setAppointmentAccepted(appointment.id, dateTime);
      requestReceived.removeWhere((item) => item.id == appointment.id);
      setBusy(false);
      return true;
    } catch (e) {
      setBusy(false);
      return false;
    }
  }
}
