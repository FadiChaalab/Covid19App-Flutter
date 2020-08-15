import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid19/src/bloc/country_bloc.dart';
import 'package:covid19/src/model/country_model.dart';
import 'package:covid19/src/model/country_response.dart';
import 'package:covid19/src/screen/detailed_screen.dart';
import 'package:covid19/src/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class SearchScreen extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    StreamSubscription<ConnectivityResult> subscription;
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile) summaryBloc..getSummary();
      },
    );
    subscription.cancel();

    return connectionStatus == ConnectivityStatus.WiFi ||
            connectionStatus == ConnectivityStatus.Cellular
        ? StreamBuilder<CountryResponse>(
            stream: summaryBloc.subject.stream,
            builder: (context, AsyncSnapshot<CountryResponse> snapshot) {
              final List<CountryModel> countryList =
                  snapshot.data == null ? [] : snapshot.data.countries;
              final List<CountryModel> search = query.isEmpty
                  ? []
                  : countryList
                      .where((element) => element.country
                          .toString()
                          .toLowerCase()
                          .startsWith(query.toLowerCase()))
                      .toList();
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildResultWidget(search);
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
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    StreamSubscription<ConnectivityResult> subscription;
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile) summaryBloc..getSummary();
      },
    );
    subscription.cancel();
    return connectionStatus == ConnectivityStatus.WiFi ||
            connectionStatus == ConnectivityStatus.Cellular
        ? StreamBuilder<CountryResponse>(
            stream: summaryBloc.subject.stream,
            builder: (context, AsyncSnapshot<CountryResponse> snapshot) {
              final List<CountryModel> countryList =
                  snapshot.data == null ? [] : snapshot.data.countries;
              final List<CountryModel> search = query.isEmpty
                  ? []
                  : countryList
                      .where((element) => element.country
                          .toString()
                          .toLowerCase()
                          .startsWith(query.toLowerCase()))
                      .toList();
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildHomeWidget(search);
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
          );
  }

  Widget _buildLoadingWidget() {
    return Center(child: CircularProgressIndicator());
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

  Widget _buildHomeWidget(List<CountryModel> data) {
    List<CountryModel> countries = data;
    if (countries.length == 0) {
      return Center(
        child: Text("No match!"),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                query = countries[index].country;
              },
              child: Text(countries[index].country),
            ),
          );
        },
      );
    }
  }

  Widget _buildResultWidget(List<CountryModel> data) {
    List<CountryModel> countries = data;
    if (countries.length == 0) {
      return Center(
        child: Text("No match!"),
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
