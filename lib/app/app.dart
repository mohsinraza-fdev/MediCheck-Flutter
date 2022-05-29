import 'package:stacked/stacked_annotations.dart';

import '../views/auth_wrapper_view.dart';
import '../views/doctor_form_view.dart';
import '../views/doctor_info_view.dart';
import '../views/find_doctor_view.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/prediction_result_view.dart';
import '../views/prediction_view.dart';
import '../views/request_view.dart';
import '../views/schedule_view.dart';
import '../views/signup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: AuthWrapperView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: RequestView),
    MaterialRoute(page: PredictionView),
    MaterialRoute(page: PredictionResultView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: FindDoctorView),
    MaterialRoute(page: DoctorInfoView),
    MaterialRoute(page: DoctorFormView),
    MaterialRoute(page: ScheduleView),
  ],
)
class AppSetup {}
