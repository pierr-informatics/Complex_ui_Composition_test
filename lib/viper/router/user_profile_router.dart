import 'package:flutter/material.dart';
import '../entity/user_profile_repository.dart';
import '../interactor/user_profile_interactor.dart';
import '../presenter/user_profile_presenter.dart';
import '../view/user_profile_view.dart';

class UserProfileRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/user-profile':
        return MaterialPageRoute(
          builder: (_) {
            // Setting up the VIPER stack
            final repository = UserProfileRepository();
            final interactor = UserProfileInteractor(repository);
            final presenter = UserProfilePresenter(interactor);

            return UserProfileView(presenter: presenter);
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static void navigateToUserProfile(BuildContext context) {
    Navigator.of(context).pushNamed('/user-profile');
  }
}
