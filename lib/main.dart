import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blood_connect/controllers/app_cubit/app_cubit.dart';
import 'package:flutter_blood_connect/controllers/auth_cubit/auth_cubit.dart';
import 'package:flutter_blood_connect/constants.dart';
import 'package:flutter_blood_connect/utils/app_cache.dart';
import 'package:flutter_blood_connect/components/components.dart';
import 'package:flutter_blood_connect/screens/donation_screen.dart';
import 'package:flutter_blood_connect/screens/home_screen.dart';
import 'package:flutter_blood_connect/screens/profile_screen.dart';
import 'package:flutter_blood_connect/utils/dio_helper.dart';

import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await AppCache.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
            create: (context) => AppCubit()
              ..getDoctors()
              ..getProfile()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: getMaterialColor(Colors.red.shade300),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
