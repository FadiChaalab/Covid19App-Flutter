import 'package:covid19/src/bloc/drawer_bloc.dart';
import 'package:covid19/src/sidbar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Discover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SidbarLayout(),
      backgroundColor: Color.fromRGBO(71, 11, 14, 1),
      body: BlocBuilder<DrawerBloc, DrawerStates>(
        builder: (context, state) {
          return state as Widget;
        },
      ),
    );
  }
}
