import 'dart:developer';

import 'package:auth/core/routes.dart';
import 'package:auth/core/theme.dart';
import 'package:auth/logic/cubits/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MainBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: 'login',
        theme: Themes.defaultTheme,
      ),
    );
  }
}

class MainBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('Bloc: $bloc created');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('Bloc: $bloc, Change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('Bloc: $bloc, Transition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('Bloc: $bloc closed');
  }
}
