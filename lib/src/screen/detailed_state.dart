import 'package:clay_containers/clay_containers.dart';
import 'package:covid19/src/model/state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DetailedStateScreen extends StatefulWidget {
  final StateModel state;

  const DetailedStateScreen({Key key, this.state}) : super(key: key);
  @override
  _DetailedStateScreenState createState() => _DetailedStateScreenState();
}

class _DetailedStateScreenState extends State<DetailedStateScreen> {
  @override
  void initState() {
    super.initState();
    getPersent();
  }

  getPersent() {
    double persent = (widget.state.deaths / widget.state.cases) * 100;
    return persent.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 15,
              forceElevated: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              expandedHeight: 200.0,
              backgroundColor: Color.fromRGBO(71, 11, 14, 1),
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    widget.state.state,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://corona.lmao.ninja/assets/img/flags/us.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(71, 11, 14, 1).withOpacity(0.6),
                          Color.fromRGBO(71, 11, 14, 1).withOpacity(0.5),
                          Color.fromRGBO(71, 11, 14, 1).withOpacity(0.4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "state Information: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ClayContainer(
                borderRadius: 20,
                child: ListTile(
                  leading: ClayContainer(
                    width: 40,
                    height: 40,
                    emboss: true,
                    color: Color(0xFFf2f2f2),
                    borderRadius: 15,
                    child: Icon(
                      FontAwesome5Solid.check_circle,
                      color: Colors.greenAccent,
                    ),
                  ),
                  title: ClayText(
                    "Total cases: " + widget.state.cases.toString(),
                    color: Colors.grey,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ClayContainer(
                borderRadius: 20,
                child: ListTile(
                  leading: ClayContainer(
                    width: 40,
                    height: 40,
                    emboss: true,
                    color: Color(0xFFf2f2f2),
                    borderRadius: 15,
                    child: Icon(
                      FontAwesome5Solid.user_plus,
                      color: Colors.greenAccent,
                    ),
                  ),
                  title: ClayText(
                    "Today cases: " + widget.state.todayCases.toString(),
                    color: Colors.grey,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ClayContainer(
                borderRadius: 20,
                child: ListTile(
                  leading: ClayContainer(
                    width: 40,
                    height: 40,
                    emboss: true,
                    color: Color(0xFFf2f2f2),
                    borderRadius: 15,
                    child: Icon(
                      FontAwesome5Solid.skull_crossbones,
                      color: Colors.red,
                    ),
                  ),
                  title: ClayText(
                    "Total deaths: " + widget.state.deaths.toString(),
                    color: Colors.grey,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ClayContainer(
                borderRadius: 20,
                child: ListTile(
                  leading: ClayContainer(
                    width: 40,
                    height: 40,
                    emboss: true,
                    color: Color(0xFFf2f2f2),
                    borderRadius: 15,
                    child: Icon(
                      FontAwesome5Solid.user_plus,
                      color: Colors.greenAccent,
                    ),
                  ),
                  title: ClayText(
                    "Today deaths: " + widget.state.todayDeaths.toString(),
                    color: Colors.grey,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ClayContainer(
                borderRadius: 20,
                child: ListTile(
                  leading: ClayContainer(
                    width: 40,
                    height: 40,
                    emboss: true,
                    color: Color(0xFFf2f2f2),
                    borderRadius: 15,
                    child: Icon(
                      FontAwesome5Solid.vial,
                      color: Colors.redAccent,
                    ),
                  ),
                  title: ClayText(
                    "Tests: " + widget.state.tests.toString(),
                    color: Colors.grey,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ClayContainer(
                borderRadius: 20,
                child: ListTile(
                  leading: ClayContainer(
                    width: 40,
                    height: 40,
                    emboss: true,
                    color: Color(0xFFf2f2f2),
                    borderRadius: 15,
                    child: Icon(
                      FontAwesome5Solid.radiation,
                      color: Colors.red,
                    ),
                  ),
                  title: ClayText(
                    "Active: " + widget.state.active.toString(),
                    color: Colors.grey,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ClayContainer(
                borderRadius: 20,
                child: ListTile(
                  leading: ClayContainer(
                    width: 40,
                    height: 40,
                    emboss: true,
                    color: Color(0xFFf2f2f2),
                    borderRadius: 15,
                    child: Icon(
                      FontAwesome.percent,
                      color: Colors.greenAccent,
                    ),
                  ),
                  title: ClayText(
                    "Persentage of deaths: " + getPersent(),
                    color: Colors.grey,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
