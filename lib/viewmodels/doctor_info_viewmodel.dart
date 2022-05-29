import 'package:maps_launcher/maps_launcher.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../models/doctors_data.dart';
import '../services/authentication_service.dart';
import '../services/doctor_service.dart';

class DoctorInfoViewModel extends BaseViewModel {
  final doctorService = locator<DoctorService>();
  final authService = locator<AuthenticationService>();

  Doctor? get currentDoctor => doctorService.currentDoctor;

  int _selectedLocation = 0;
  int get selectedLocation => _selectedLocation;
  set selectedLocation(int value) {
    _selectedLocation = value;
    notifyListeners();
  }

  Future openMaps() async {
    if (currentDoctor!.locations![selectedLocation].latlong != 'xox') {
      await MapsLauncher.launchCoordinates(
        double.parse(currentDoctor!.locations![selectedLocation].latlong!
            .split(' ')[0]
            .substring(0, 10)),
        double.parse(currentDoctor!.locations![selectedLocation].latlong!
            .split(' ')[1]
            .substring(0, 10)),
        currentDoctor!.locations![selectedLocation].name,
      );
    }
  }

  Future<bool?> getAppointment() async {
    setBusy(true);
    if (authService.user!.uid == currentDoctor!.id) {
      setBusy(false);
      return null;
    } else {
      try {
        await authService.createAppointment(currentDoctor!);
        setBusy(false);
        return true;
      } catch (e) {
        setBusy(false);
        return false;
      }
    }
  }

  Future<bool?> verifyAppointment() async {
    setBusy(true);
    bool? existence =
        await authService.checkAppointmentExistence(currentDoctor!);
    setBusy(false);
    return existence;
  }
}
