import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid19/src/bloc/total_bloc.dart';
import 'package:covid19/src/model/total_model.dart';
import 'package:covid19/src/screen/discover_screen.dart';
import 'package:covid19/src/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;
  @override
  void initState() {
    super.initState();
    getResult();
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale2Animation = Tween<double>(begin: 1.0, end: 32.0).animate(
        _scale2Controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.fade, child: Discover()));
        }
      });
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(71, 11, 14, 1),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                    ),
                    Text(
                      "Corona Virus",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Pandemic",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      "Covid-19",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.black45,
                      ),
                    ),
                    connectionStatus == ConnectivityStatus.WiFi ||
                            connectionStatus == ConnectivityStatus.Cellular
                        ? StreamBuilder<TotalModel>(
                            stream: totalBloc.subject.stream,
                            builder:
                                (context, AsyncSnapshot<TotalModel> snapshot) {
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
                        : Text(
                            "Connection lost...",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FloatingActionButton(
                            backgroundColor: Color.fromRGBO(71, 11, 14, 1),
                            elevation: 5,
                            child: Icon(Icons.add_alert),
                            onPressed: () {},
                          ),
                          Container(
                            width: 200,
                            child: Image.asset('assets/images/covid19.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: AnimatedBuilder(
                animation: _scaleController,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _widthController,
                      builder: (context, child) => Container(
                        width: _widthAnimation.value,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromRGBO(139, 46, 44, 1),
                        ),
                        child: InkWell(
                          onTap: () {
                            _scaleController.forward();
                          },
                          child: Stack(children: <Widget>[
                            AnimatedBuilder(
                              animation: _positionController,
                              builder: (context, child) => Positioned(
                                left: _positionAnimation.value,
                                child: AnimatedBuilder(
                                  animation: _scale2Controller,
                                  builder: (context, child) => Transform.scale(
                                    scale: _scale2Animation.value,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(71, 11, 14, 1),
                                      ),
                                      child: hideIcon == false
                                          ? Center(
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
  return Row(
    children: <Widget>[
      Text(
        data.recovered.toString(),
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        "Recovered",
        style: TextStyle(
          color: Colors.green,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    ],
  );
}
