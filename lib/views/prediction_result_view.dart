import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../app/colors.dart';
import '../viewmodels/prediction_result_viewmodel.dart';
import 'find_doctor_view.dart';

class PredictionResultView extends StatelessWidget {
  const PredictionResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PredictionResultViewModel>.reactive(
      viewModelBuilder: () => PredictionResultViewModel(),
      onModelReady: (viewModel) => viewModel.getPrediction(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: appBackground,
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: appYellow,
              child: Column(
                children: const [
                  SizedBox(height: 70),
                  Text(
                    'Prediction Results',
                    style: TextStyle(
                        color: appBackground,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: model.isLoading
                  ? const SpinKitSpinningLines(
                      size: 100,
                      color: appYellow,
                      lineWidth: 3,
                      duration: Duration(milliseconds: 1500),
                    )
                  : model.result == null
                      ? const Center(
                          child: Text(
                            'Conection Failed',
                            style: TextStyle(
                                color: appYellow,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 7),
                            ...List.generate(
                              model.result!.data!.length,
                              (index) => GestureDetector(
                                onTap: () => model.selectedPrediction = index,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: model.selectedPrediction == index
                                        ? appYellow
                                        : appBackground,
                                    border: Border.all(
                                      width: 2,
                                      color: appYellow,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        model.result!.data![index].name!,
                                        style: TextStyle(
                                            color: model.selectedPrediction ==
                                                    index
                                                ? appBackground
                                                : appYellow,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Probablity: ' +
                                            model.result!.data![index]
                                                .probablity!
                                                .toString()
                                                .substring(0, 4) +
                                            ' %',
                                        style: TextStyle(
                                            color: model.selectedPrediction ==
                                                    index
                                                ? appBackground
                                                : appYellow,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => FindDoctorView(
                                              specialization:
                                                  model.getSpecByDisease(model
                                                      .result!
                                                      .data![model
                                                          .selectedPrediction]
                                                      .name!),
                                            )));
                              },
                              child: Container(
                                height: 60,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                  color: appYellow,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'Get Help',
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
          ],
        ),
      ),
    );
  }
}
