import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid19/src/bloc/drawer_bloc.dart';
import 'package:covid19/src/bloc/state_bloc.dart';
import 'package:covid19/src/model/state_model.dart';
import 'package:covid19/src/model/state_response.dart';
import 'package:covid19/src/screen/detailed_state.dart';
import 'package:covid19/src/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class StateScreen extends StatefulWidget with DrawerStates {
  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation color;
  @override
  void initState() {
    super.initState();
    getStates();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    color = ColorTween(begin: Colors.indigo, end: Colors.orange)
        .animate(controller);
  }

  Future getStates() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile)
      setState(() {
        stateBloc..getStates();
      });
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return connectionStatus == ConnectivityStatus.WiFi ||
            connectionStatus == ConnectivityStatus.Cellular
        ? RefreshIndicator(
            onRefresh: getStates,
            child: StreamBuilder<StateResponse>(
              stream: stateBloc.subject.stream,
              builder: (context, AsyncSnapshot<StateResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return _buildErrorWidget(snapshot.data.error);
                  }
                  return _buildHomeWidget(snapshot.data);
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error);
                } else {
                  return _buildLoadingWidget();
                }
              },
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Feather.wifi_off,
                  color: Colors.grey.withOpacity(0.7),
                  size: 40,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Connection lost!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: color,
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(StateResponse data) {
    List<StateModel> states = data.states;
    if (states.length == 0) {
      return Center(
        child: Text("No state!"),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: states.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedStateScreen(
                      state: states[index],
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(states[index].state),
                  subtitle: Text("Deaths: " + states[index].deaths.toString()),
                  trailing: Text("Cases: " + states[index].cases.toString()),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
