import 'package:connectivity/connectivity.dart';
import 'package:covid19/src/bloc/drawer_bloc.dart';
import 'package:covid19/src/bloc/historic_bloc.dart';
import 'package:covid19/src/model/historic.dart';
import 'package:covid19/src/model/historic_response.dart';
import 'package:covid19/src/screen/detailed_historic_screen.dart';
import 'package:covid19/src/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget with DrawerStates {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation color;
  @override
  void initState() {
    super.initState();
    getHistorics();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    color = ColorTween(begin: Colors.indigo, end: Colors.orange)
        .animate(controller);
  }

  Future getHistorics() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile)
      setState(() {
        historicBloc..getHistoric();
      });
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return connectionStatus == ConnectivityStatus.WiFi ||
            connectionStatus == ConnectivityStatus.Cellular
        ? RefreshIndicator(
            onRefresh: getHistorics,
            child: StreamBuilder<HistoricResponse>(
              stream: historicBloc.subject.stream,
              builder: (context, AsyncSnapshot<HistoricResponse> snapshot) {
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

  Widget _buildHomeWidget(HistoricResponse data) {
    List<Historic> historics = data.historics;
    if (historics.length == 0) {
      return Center(
        child: Text("No historic!"),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: historics.length,
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
                    builder: (context) => DetailedHistoricScreen(
                      historic: historics[index],
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(historics[index].country),
                  subtitle: Text("Deaths: " +
                      historics[index].timeline.deaths.values.last.toString()),
                  trailing: Text("Cases: " +
                      historics[index].timeline.cases.values.last.toString()),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
