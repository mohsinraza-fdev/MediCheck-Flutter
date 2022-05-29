import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../viewmodels/doctor_form_viewmodel.dart';

class DoctorFormView extends HookWidget {
  const DoctorFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController clinicName = useTextEditingController();
    TextEditingController experience = useTextEditingController();
    TextEditingController bio = useTextEditingController();
    TextEditingController location = useTextEditingController();
    FocusNode focus1 = useFocusNode();
    FocusNode focus2 = useFocusNode();
    FocusNode focus3 = useFocusNode();
    FocusNode focus4 = useFocusNode();

    void _fireFormChanged(DoctorFormViewModel viewModel) {
      viewModel.setData({
        "clinicName": clinicName.text,
        "experience": experience.text,
        "bio": bio.text,
        "location": location.text,
      });
    }

    return ViewModelBuilder<DoctorFormViewModel>.reactive(
      viewModelBuilder: () => DoctorFormViewModel(),
      onModelReady: (viewModel) => viewModel.setData({
        "clinicName": clinicName.text,
        "experience": experience.text,
        "bio": bio.text,
        "location": location.text,
      }),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: appBackground,
          body: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: appYellow,
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    const Text(
                      'Doctor Form',
                      style: TextStyle(
                          color: appBackground,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: appYellow.withOpacity(0.5),
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Basic Info:',
                              style: TextStyle(
                                  color: appYellow,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: appYellow),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: clinicName,
                            focusNode: focus1,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                            maxLines: 1,
                            onChanged: (text) {
                              _fireFormChanged(model);
                            },
                            onSubmitted: (text) {
                              FocusScope.of(context).requestFocus(focus2);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              hintText: 'Clinic Name',
                              hintStyle: TextStyle(
                                  color: appYellow,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: appYellow),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: experience,
                            focusNode: focus2,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                            maxLines: 1,
                            onChanged: (text) {
                              _fireFormChanged(model);
                            },
                            onSubmitted: (text) {
                              FocusScope.of(context).requestFocus(focus3);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              hintText: 'Experience',
                              hintStyle: TextStyle(
                                  color: appYellow,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: appYellow),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: bio,
                            focusNode: focus3,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                            maxLines: 1,
                            onChanged: (text) {
                              _fireFormChanged(model);
                            },
                            onSubmitted: (text) {
                              FocusScope.of(context).requestFocus(focus4);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              hintText: 'Bio',
                              hintStyle: TextStyle(
                                  color: appYellow,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: appYellow),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextField(
                            controller: location,
                            focusNode: focus4,
                            cursorColor: appYellow,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: appYellow,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                            maxLines: 1,
                            onChanged: (text) {
                              _fireFormChanged(model);
                            },
                            onSubmitted: (text) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              hintText: 'Location (Latitude, Longitude)',
                              hintStyle: TextStyle(
                                  color: appYellow,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal),
                              suffixIcon: Icon(
                                Icons.location_pin,
                                color: appYellow,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 23),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Availability:',
                              style: TextStyle(
                                  color: appYellow,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: List.generate(
                                model.dayNames.length,
                                (index) => GestureDetector(
                                  onTap: () => model.toggleChip(index),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    width: 70,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        left: 6, right: 6, bottom: 12),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 7.5),
                                    decoration: BoxDecoration(
                                      color: model.selectedDays[index] == 0
                                          ? Colors.transparent
                                          : appYellow,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: appYellow),
                                    ),
                                    child: Text(
                                      model.dayNames[index],
                                      style: TextStyle(
                                          color: model.selectedDays[index] == 0
                                              ? appYellow
                                              : appBackground,
                                          fontSize: 15,
                                          fontWeight:
                                              model.selectedDays[index] == 0
                                                  ? FontWeight.w400
                                                  : FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 9),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Specializations:',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: appYellow,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: List.generate(
                                model.specializationNames.length,
                                (index) => GestureDetector(
                                  onTap: () =>
                                      model.toggleSpecializationChip(index),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    width: double.maxFinite,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        left: 6, right: 6, bottom: 12),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 7.5),
                                    decoration: BoxDecoration(
                                      color: model.selectedSpecializations[
                                                  index] ==
                                              0
                                          ? Colors.transparent
                                          : appYellow,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: appYellow),
                                    ),
                                    child: Text(
                                      model.specializationNames[index],
                                      style: TextStyle(
                                          color: model.selectedSpecializations[
                                                      index] ==
                                                  0
                                              ? appYellow
                                              : appBackground,
                                          fontSize: 15,
                                          fontWeight:
                                              model.selectedSpecializations[
                                                          index] ==
                                                      0
                                                  ? FontWeight.w400
                                                  : FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.center,
                height: 17,
                child: FittedBox(
                  child: Text(
                    model.validationMessage ?? " ",
                    style: TextStyle(color: Color.fromARGB(255, 216, 97, 89)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  model.validateAndSubmitForm();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 52,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: appYellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: appBackground,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
