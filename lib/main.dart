import 'package:covid19/src/bloc/drawer_bloc.dart';
import 'package:covid19/src/utils/enum.dart';
import 'package:covid19/src/utils/index.dart';
import 'package:covid19/src/utils/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'src/screen/home_screen.dart';
import 'package:flutter/services.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<IndexSelected>(
            create: (context) => IndexSelected(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );
    return BlocProvider<DrawerBloc>(
      create: (context) => DrawerBloc(),
      child: StreamProvider<ConnectivityStatus>(
        create: (context) =>
            ConnectivityService().connectionStatusController.stream,
        child: MaterialApp(
          title: 'Covid19',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Poppins',
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
