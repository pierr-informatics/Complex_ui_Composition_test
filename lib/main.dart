import 'package:flutter/material.dart';
import 'viper/entity/user_profile_repository.dart';
import 'viper/interactor/user_profile_interactor.dart';
import 'viper/presenter/user_profile_presenter.dart';
import 'viper/view/user_profile_view.dart';
import 'viper/router/user_profile_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VIPER Complex UI Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      onGenerateRoute: UserProfileRouter.generateRoute,
      home: _createUserProfileScreen(),
    );
  }

  Widget _createUserProfileScreen() {
    // Setting up the VIPER stack
    final repository = UserProfileRepository();
    final interactor = UserProfileInteractor(repository);
    final presenter = UserProfilePresenter(interactor);

    return UserProfileView(presenter: presenter);
  }
}
