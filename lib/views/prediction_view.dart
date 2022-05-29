import 'package:flutter/material.dart';
import 'package:medicheck/views/prediction_result_view.dart';
import 'package:stacked/stacked.dart';
import '../app/colors.dart';
import '../viewmodels/prediction_viewmodel.dart';

class PredictionView extends StatelessWidget {
  const PredictionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PredictionViewModel>.reactive(
      viewModelBuilder: () => PredictionViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: appBackground,
        body: SizedBox.expand(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: appYellow,
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    const Text(
                      'Select Symptoms',
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(
                        model.symptomNames.length,
                        (index) => GestureDetector(
                          onTap: () => model.toggleChip(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: model.selectedSymptoms[index] == 0
                                  ? Colors.transparent
                                  : appYellow,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(width: 2, color: appYellow),
                            ),
                            child: Text(
                              model.symptomNames[index],
                              style: TextStyle(
                                  color: model.selectedSymptoms[index] == 0
                                      ? appYellow
                                      : appBackground,
                                  fontSize: 15,
                                  fontWeight: model.selectedSymptoms[index] == 0
                                      ? FontWeight.normal
                                      : FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (model.errorMessage != null)
                Text(
                  model.errorMessage.toString(),
                  style:
                      const TextStyle(color: Color.fromARGB(255, 216, 97, 89)),
                ),
              GestureDetector(
                onTap: () {
                  if (model.checkValidity() == true) {
                    model.predict();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PredictionResultView()));
                  }
                },
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: appYellow,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Predict Disease',
                    style: TextStyle(
                        color: appBackground,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
