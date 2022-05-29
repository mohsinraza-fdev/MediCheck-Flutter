import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../models/doctors_data.dart';
import '../services/authentication_service.dart';
import '../services/doctor_service.dart';

class FindDoctorViewModel extends BaseViewModel {
  final doctorService = locator<DoctorService>();
  final authService = locator<AuthenticationService>();

  List<Doctor> get allDoctors => doctorService.doctors;
  TextEditingController searchBarController = TextEditingController();

  List<Doctor> doctors = <Doctor>[];

  bool _isloading = true;
  bool get isLoading => _isloading;
  set isLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void loadDoctors(String? spec) async {
    try {
      await doctorService.getDoctors();

      if (spec != null) {
        await doctorService.filter(spec);
      }
    } catch (e) {}
    filter();
    isLoading = false;
  }

  void setInfoDoctor(Doctor doc) {
    doctorService.currentDoctor = doc;
  }

  void filter() {
    if (searchBarController.text == '') {
      doctors = allDoctors;
    } else {
      doctors = <Doctor>[];
      allDoctors.forEach((doctor) {
        List<String> words = doctor.name!.split(' ');
        doctor.specialization!.forEach((item) {
          words += item.split(' ');
        });
        List<String> searchWords = searchBarController.text.split(' ');
        int target = searchWords.length;
        int count = 0;
        for (String word in words) {
          for (String searchWord in searchWords) {
            if (word.toLowerCase().startsWith(searchWord.toLowerCase())) {
              count++;
              searchWords.removeWhere((queryWord) => queryWord == searchWord);
              break;
            }
          }
        }
        if (count == target) {
          doctors.add(doctor);
        }
      });
    }
    notifyListeners();
  }

  reset() {
    searchBarController.text = '';
    filter();
    notifyListeners();
  }

  onDispose() {
    searchBarController.dispose();
  }
}
