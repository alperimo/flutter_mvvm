import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'package:readytostart_base_mvvm_project/core/routes/routing_constants.dart';
import 'package:readytostart_base_mvvm_project/core/routes/undefined_route.dart';
import 'package:readytostart_base_mvvm_project/locator.dart';
import 'package:readytostart_base_mvvm_project/views/createprofile_view.dart';
import 'package:readytostart_base_mvvm_project/views/home_view.dart';
import 'package:readytostart_base_mvvm_project/views/landing_view.dart';
import 'package:readytostart_base_mvvm_project/views/signin_view.dart';
import 'package:readytostart_base_mvvm_project/views/signup_view.dart';
import 'package:readytostart_base_mvvm_project/views/starter_view.dart';

import 'package:stacked_services/stacked_services.dart';

class Router {
  final NavigationService navigationService = locator<NavigationService>();

  dynamic getScreen(RouteSettings settings) {
    switch (settings.name) {
      case starterRoute:
        return const StarterScreen();
      case landingRoute:
        return LandingScreen();
      case signUpRoute:
        return SignUpScreen();
      case signInRoute:
        return SignInScreen();
        case createProfileRoute:
        return CreateProfileScreen();
      case homeRoute:
        return HomeScreen();
      default:
        return const UndefinedRouteView();
    }
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case starterRoute:
        return CupertinoPageRoute(builder: (_) => const StarterScreen());
      default:
        var screen = getScreen(settings);

        return PageTransition(
          child: screen,
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
          reverseDuration: const Duration(milliseconds: 100),
        );
    }
  }

  // Without context
  Future navigateToWithoutContext(String routeName) async{
    navigationService.navigateTo(routeName);
  }

  Future clearStackAndShowWithoutContext(String routeName) async{
    navigationService.clearStackAndShow(routeName);
  }

  Future replaceWithWithoutContext(String routeName) async{
    navigationService.replaceWith(routeName);
  }

  // With context for PersistentTabView
  Future navigateTo(BuildContext context, String routeName) async {
    if (context.mounted){
      Navigator.of(context).push(
          onGenerateRoute(RouteSettings(name: routeName))
      );
    }
  }

  Future navigateToWithRouteSettings(BuildContext context, RouteSettings routeSettings) async {
    if (context.mounted){
      Navigator.of(context).push(
          onGenerateRoute(routeSettings)
      );
    }
  }

  Future replaceWith(BuildContext context, String routeName) async {
    if (context.mounted){
      Navigator.of(context).pushReplacement(
          onGenerateRoute(RouteSettings(name: routeName))
      );
    }
  }

  Future clearStackAndShow(BuildContext context, String routeName) async {
    if (context.mounted){
      Navigator.of(context).pushAndRemoveUntil(
          onGenerateRoute(RouteSettings(name: routeName)),
              (route) => false
      );
    }
  }

  // Navigation methods
  Future navigateLandingScreen() async {
    clearStackAndShowWithoutContext(starterRoute);
  }

  Future navigateSignInScreen() async {
    navigateToWithoutContext(signInRoute);
  }

  Future navigateSignUpScreen() async {
    navigateToWithoutContext(signUpRoute);
  }

  Future navigateCreateProfileScreen() async {
    navigateToWithoutContext(createProfileRoute);
  }

  Future navigateHomeScreen() async {
    clearStackAndShowWithoutContext(homeRoute);
  }
}