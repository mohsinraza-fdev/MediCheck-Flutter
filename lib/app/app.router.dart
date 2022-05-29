// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
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

class Routes {
  static const String authWrapperView = '/';
  static const String loginView = '/login-view';
  static const String signupView = '/signup-view';
  static const String requestView = '/request-view';
  static const String predictionView = '/prediction-view';
  static const String predictionResultView = '/prediction-result-view';
  static const String homeView = '/home-view';
  static const String findDoctorView = '/find-doctor-view';
  static const String doctorInfoView = '/doctor-info-view';
  static const String doctorFormView = '/doctor-form-view';
  static const String scheduleView = '/schedule-view';
  static const all = <String>{
    authWrapperView,
    loginView,
    signupView,
    requestView,
    predictionView,
    predictionResultView,
    homeView,
    findDoctorView,
    doctorInfoView,
    doctorFormView,
    scheduleView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.authWrapperView, page: AuthWrapperView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.signupView, page: SignupView),
    RouteDef(Routes.requestView, page: RequestView),
    RouteDef(Routes.predictionView, page: PredictionView),
    RouteDef(Routes.predictionResultView, page: PredictionResultView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.findDoctorView, page: FindDoctorView),
    RouteDef(Routes.doctorInfoView, page: DoctorInfoView),
    RouteDef(Routes.doctorFormView, page: DoctorFormView),
    RouteDef(Routes.scheduleView, page: ScheduleView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    AuthWrapperView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AuthWrapperView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    SignupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignupView(),
        settings: data,
      );
    },
    RequestView: (data) {
      var args = data.getArgs<RequestViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RequestView(
          key: args.key,
          count: args.count,
        ),
        settings: data,
      );
    },
    PredictionView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PredictionView(),
        settings: data,
      );
    },
    PredictionResultView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PredictionResultView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    FindDoctorView: (data) {
      var args = data.getArgs<FindDoctorViewArguments>(
        orElse: () => FindDoctorViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => FindDoctorView(
          key: args.key,
          specialization: args.specialization,
        ),
        settings: data,
      );
    },
    DoctorInfoView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DoctorInfoView(),
        settings: data,
      );
    },
    DoctorFormView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DoctorFormView(),
        settings: data,
      );
    },
    ScheduleView: (data) {
      var args = data.getArgs<ScheduleViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ScheduleView(
          key: args.key,
          count: args.count,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// RequestView arguments holder class
class RequestViewArguments {
  final Key? key;
  final int count;
  RequestViewArguments({this.key, required this.count});
}

/// FindDoctorView arguments holder class
class FindDoctorViewArguments {
  final Key? key;
  final String? specialization;
  FindDoctorViewArguments({this.key, this.specialization});
}

/// ScheduleView arguments holder class
class ScheduleViewArguments {
  final Key? key;
  final int count;
  ScheduleViewArguments({this.key, required this.count});
}
