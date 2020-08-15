import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid19/src/bloc/country_bloc.dart';
import 'package:covid19/src/bloc/drawer_bloc.dart';
import 'package:covid19/src/model/country_model.dart';
import 'package:covid19/src/model/country_response.dart';
import 'package:covid19/src/screen/detailed_screen.dart';
import 'package:covid19/src/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatefulWidget with DrawerStates {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation color;
  @override
  void initState() {
    super.initState();
    getSummary();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    color = ColorTween(begin: Colors.indigo, end: Colors.orange)
        .animate(controller);
  }

  Future getSummary() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile)
      setState(() {
        summaryBloc..getSummary();
      });
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return connectionStatus == ConnectivityStatus.WiFi ||
            connectionStatus == ConnectivityStatus.Cellular
        ? RefreshIndicator(
            onRefresh: getSummary,
            child: StreamBuilder<CountryResponse>(
              stream: summaryBloc.subject.stream,
              builder: (context, AsyncSnapshot<CountryResponse> snapshot) {
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

  Widget _buildHomeWidget(CountryResponse data) {
    List<CountryModel> countries = data.countries;
    if (countries.length == 0) {
      return Center(
        child: Text("No summary!"),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: countries.length,
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
                    builder: (context) => DetailedScreen(
                      country: countries[index],
                    ),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      countries[index].flag,
                    ),
                  ),
                  title: Text(countries[index].country),
                  subtitle:
                      Text("Deaths: " + countries[index].deaths.toString()),
                  trailing: Text("Cases: " + countries[index].cases.toString()),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
