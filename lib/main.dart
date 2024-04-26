import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_place_app/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_place_app/data/datasource/places_remote_datasource.dart';
import 'package:flutter_place_app/ui/bloc/create_place/create_place_bloc.dart';
import 'package:flutter_place_app/ui/bloc/delete_place/delete_place_bloc.dart';
import 'package:flutter_place_app/ui/bloc/get_all_places/get_all_places_bloc.dart';
import 'package:flutter_place_app/ui/bloc/login/login_bloc.dart';
import 'package:flutter_place_app/ui/bloc/logout/logout_bloc.dart';
import 'package:flutter_place_app/ui/bloc/register/register_bloc.dart';
import 'package:flutter_place_app/ui/bloc/update_places/update_places_bloc.dart';
import 'package:flutter_place_app/ui/pages/home_page.dart';
import 'package:flutter_place_app/ui/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/core.dart';
import 'data/datasource/auth_local_datasource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetAllPlacesBloc(PlacesRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => DeletePlaceBloc(PlacesRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdatePlacesBloc(PlacesRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CreatePlaceBloc(PlacesRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dividerTheme:
              DividerThemeData(color: AppColors.light.withOpacity(0.5)),
          dialogTheme: const DialogTheme(elevation: 0),
          textTheme: GoogleFonts.kumbhSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.kumbhSans(
              color: AppColors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: FutureBuilder(
          future: Future.delayed(
            const Duration(seconds: 3),
            () => AuthLocalDataSource().isUserLoggedIn(),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(color: AppColors.white),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
              );
            } else if (snapshot.hasData && snapshot.data == true) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
