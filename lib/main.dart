

import 'package:camp_web/Provider/AdminPage.dart';
import 'package:camp_web/configure_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'UI/Widgets/AdminLateral.dart';
import 'bloc/bloc_user.dart';

void main() async {
  await Firebase.initializeApp();
  configureApp();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AdmPageProvider()),
        ],
        child: MyApp(),
      ),
  );
}

double collapsableHeight = 0.0;
Color selected = Color(0Xff2056a1);
Color notSelected = Colors.grey;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return BlocProvider<UserBloc>(
        bloc: UserBloc(),
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('es')
          ],
          debugShowCheckedModeBanner: false,
          home: AdmLateralBar(),
        ));
  }
}