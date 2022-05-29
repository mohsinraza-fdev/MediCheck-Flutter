import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../models/enums.dart';
import '../services/authentication_service.dart';

class DoctorFormViewModel extends FormViewModel {
  final authService = locator<AuthenticationService>();
  final navigator = locator<NavigationService>();

  List<String> dayNames = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  List<int> selectedDays = <int>[
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  List<String> specializationNames = <String>[
    "Clinical Nutritionist",
    "Physiotherapist",
    "Dentist",
    "General Practitioner",
    "Dermatologist",
    "General Physician",
    "Cardiologist",
    "Pulmonologist / Lung Specialist",
    "Plastic Surgeon",
    "Gynecologist",
    "Pediatric Surgeon",
    "Ent Surgeon",
    "Cancer Specialist / Oncologist",
    "Orthopedic Surgeon",
    "Andrologist",
    "Laparoscopic Surgeon",
    "Pediatric Urologist",
    "Sexologist",
    "Urologist",
    "Diabetologist",
    "General Surgeon",
    "Nephrologist",
    "Pediatrician",
    "Bariatric / Weight Loss Surgeon",
    "Neonatologist",
    "Rheumatologist",
    "Endocrinologist",
    "Cancer Surgeon",
    "Family Medicine"
  ];

  List<int> selectedSpecializations = <int>[
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];

  toggleSpecializationChip(int index) {
    setValidationMessage(null);
    notifyListeners();
    if (selectedSpecializations[index] == 0) {
      selectedSpecializations[index] = 1;
    } else {
      selectedSpecializations[index] = 0;
    }
    notifyListeners();
  }

  Map<String, dynamic> doctorFormat = {
    "description": " ",
    "experience": 0,
    "id": "xox",
    "locations": [
      {
        "days": [],
        "latlong": "xox",
        "name": " ",
        "timing": {"from": "00:00 ", "to": "23:59"}
      }
    ],
    "name": " ",
    "specialization": []
  };

  toggleChip(int index) {
    setValidationMessage(null);
    notifyListeners();
    if (selectedDays[index] == 0) {
      selectedDays[index] = 1;
    } else {
      selectedDays[index] = 0;
    }
    notifyListeners();
  }

  validateAndSubmitForm() {
    if (formValueMap['clinicName'] == '' ||
        formValueMap['experience'] == '' ||
        formValueMap['bio'] == '' ||
        formValueMap['location'] == '') {
      setValidationMessage('Please fill all fields');
    } else if (!selectedDays.contains(1)) {
      setValidationMessage('Please select atleast 1 day');
    } else if (!selectedSpecializations.contains(1)) {
      setValidationMessage('Must have atleast 1 Specialization');
    } else {
      doctorFormat["description"] = formValueMap['bio'];
      doctorFormat["experience"] = int.parse(formValueMap['experience']);
      doctorFormat["locations"][0]["days"] =
          getSelections(dayNames, selectedDays);
      doctorFormat["locations"][0]["latlong"] = formValueMap['location'];
      doctorFormat["locations"][0]["name"] = formValueMap['clinicName'];
      doctorFormat["specialization"] =
          getSelections(specializationNames, selectedSpecializations);
      authService.doctorInfo = doctorFormat;
      authService.accountType = AccountType.doctor;
      navigator.back();
    }
    notifyListeners();
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  List<String> getSelections(List<String> textList, List<int> selectionList) {
    List<String> result = <String>[];
    int index = -1;
    selectionList.forEach((selection) {
      index++;
      if (selection == 1) {
        result.add(textList[index]);
      }
    });
    return result;
  }
}
