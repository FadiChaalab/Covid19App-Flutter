import 'dart:async';

import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:covid19/src/bloc/drawer_bloc.dart';
import 'package:covid19/src/bloc/total_bloc.dart';
import 'package:covid19/src/model/total_model.dart';
import 'package:covid19/src/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class GlobalScreen extends StatefulWidget with DrawerStates {
  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> {
  @override
  void initState() {
    super.initState();
    getResult();
  }

  Future getResult() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile)
      setState(() {
        totalBloc..getTotal();
      });
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 120,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Global Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.white54,
                  shadows: [
                    Shadow(
                      blurRadius: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.info,
                color: Color.fromRGBO(101, 53, 55, 1),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        ClayContainer(
          borderRadius: 20,
          height: 400,
          color: Color.fromRGBO(71, 11, 14, 1),
          curveType: CurveType.convex,
          width: MediaQuery.of(context).size.width - 64,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                connectionStatus == ConnectivityStatus.WiFi ||
                        connectionStatus == ConnectivityStatus.Cellular
                    ? StreamBuilder<TotalModel>(
                        stream: totalBloc.subject.stream,
                        builder: (context, AsyncSnapshot<TotalModel> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.error != null) {
                              return _buildErrorWidget(snapshot.error);
                            }
                            return _buildHomeWidget(snapshot.data);
                          } else if (snapshot.hasError) {
                            return _buildErrorWidget(snapshot.error);
                          } else {
                            return _buildLoadingWidget();
                          }
                        },
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
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        width: 200,
                        child: Image.asset('assets/images/covid19.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildLoadingWidget() {
  return Text(
    "Loading...",
    style: TextStyle(
      color: Colors.grey,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
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

Widget _buildHomeWidget(TotalModel data) {
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            "Confirmed: ",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          Text(
            data.cases.toString(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: <Widget>[
          Text(
            "Recovered: ",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          Text(
            data.recovered.toString(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: <Widget>[
          Text(
            "Deaths: ",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          Text(
            data.deaths.toString(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ],
  );
}
