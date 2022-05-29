import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/api.dart';
import '../app/locator.dart';
import '../models/doctors_data.dart';
import 'authentication_service.dart';

@lazySingleton
class DoctorService {
  final authService = locator<AuthenticationService>();
  final navigator = locator<NavigationService>();

  List<Doctor> doctors = <Doctor>[];
  List<String> specs = <String>[];

  Future getDoctors() async {
    try {
      DoctorData doctorsData = await Api.getDoctorData();
      doctors = doctorsData.doctors!;
      List<Doctor> registeredDoctors = await authService.getDoctors();
      doctors += registeredDoctors;
      doctors.sort((a, b) => a.experience!.compareTo(b.experience!));
      specs = doctorsData.specs!;
    } catch (e) {
      throw (e.toString());
    }
  }

  Doctor? currentDoctor;

  String? predictionUrl;

  filter(String? spec) async {
    try {
      if (doctors.isNotEmpty) {
        List<Doctor> newDoctors = <Doctor>[];
        doctors.forEach((element) {
          if (element.specialization!.contains(spec)) {
            newDoctors.add(element);
          }
        });
        doctors = newDoctors;
        List<Doctor> distanceDoctors = <Doctor>[];
        Position position = await _determinePosition();
        doctors.forEach((doctor) {
          String? latlong = getLatLong(doctor);
          if (latlong != null) {
            double lat1 = double.parse(latlong.split(',')[0].trim());
            double lon1 = double.parse(latlong.split(',')[1].trim());
            double lat2 = position.latitude;
            double lon2 = position.longitude;
            double distance = calculateDistance(lat1, lon1, lat2, lon2);
            doctor.distance = double.parse(distance.toStringAsFixed(2));
            distanceDoctors.add(doctor);
          }
        });
        doctors = distanceDoctors;
        doctors.sort((a, b) => a.distance.compareTo(b.distance));
      }
    } catch (e) {
      navigator.back();
    }
  }

  String? getLatLong(Doctor doctor) {
    DateTime now = DateTime.now();
    String? result;
    for (Locations location in doctor.locations!) {
      if (location.latlong! != "xox") {
        DateTime docMin = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(location.timing!.from!.split(":")[0]),
            int.parse(location.timing!.from!.split(":")[1]));
        DateTime docMax = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(location.timing!.to!.split(":")[0]),
            int.parse(location.timing!.to!.split(":")[1]));
        if (docMin.isBefore(now) &&
            docMax.isAfter(now) &&
            location.days!.contains(getWeek(DateTime.now().weekday))) {
          result = location.latlong!;
        }
      }
    }
    return result;
  }

  getWeek(int index) {
    switch (index) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
