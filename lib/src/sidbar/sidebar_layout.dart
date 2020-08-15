import 'package:after_layout/after_layout.dart';
import 'package:covid19/src/bloc/drawer_bloc.dart';
import 'package:covid19/src/screen/search_screen.dart';
import 'package:covid19/src/sidbar/sidebar_item.dart';
import 'package:covid19/src/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SidbarLayout extends StatefulWidget {
  @override
  _SidbarLayoutState createState() => _SidbarLayoutState();
}

class _SidbarLayoutState extends State<SidbarLayout> with AfterLayoutMixin {
  int selectedIndex = 0;
  LabeledGlobalKey _homeKey = LabeledGlobalKey('homeKey');
  LabeledGlobalKey _aboutKey = LabeledGlobalKey('aboutKey');
  LabeledGlobalKey _accountKey = LabeledGlobalKey('accountKey');
  LabeledGlobalKey _settingsKey = LabeledGlobalKey('settingsKey');
  RenderBox renderBox;
  double yPosition;
  int index;
  onTap(int index) {
    setState(() {
      selectedIndex = index;
      switch (selectedIndex) {
        case 0:
          renderBox = _homeKey.currentContext.findRenderObject();
          break;
        case 1:
          renderBox = _aboutKey.currentContext.findRenderObject();
          break;
        case 2:
          renderBox = _accountKey.currentContext.findRenderObject();
          break;
        case 3:
          renderBox = _settingsKey.currentContext.findRenderObject();
          break;
      }
      yPosition = renderBox.localToGlobal(Offset.zero).dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    IndexSelected selected = Provider.of<IndexSelected>(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          width: 90,
          child: ClipPath(
            clipper: SidebarClipper((yPosition == null) ? 0 : yPosition - 40,
                (yPosition == null) ? 0 : yPosition + 80),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(180, 60, 56, 1),
                    Color.fromRGBO(155, 58, 56, 1),
                    Color.fromRGBO(237, 129, 78, 1),
                    Color.fromRGBO(101, 53, 55, 1),
                    Color.fromRGBO(71, 11, 14, 1),
                  ],
                  stops: [0.05, 0.3, 0.55, 0.8, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: -10,
          bottom: 0,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              IconButton(
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  showSearch(context: context, delegate: SearchScreen());
                },
              ),
              SizedBox(
                height: 60,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SidebarItem(
                      key: _homeKey,
                      isSelected: selectedIndex == 0,
                      text: "Summary",
                      onTap: () {
                        setState(() {
                          Provider.of<IndexSelected>(context, listen: false)
                              .setIndex(0);
                          onTap(selected.getIndex());
                        });
                        BlocProvider.of<DrawerBloc>(context)
                            .add(DrawerEvents.SummaryEvent);
                      },
                    ),
                    SidebarItem(
                      key: _aboutKey,
                      isSelected: selectedIndex == 1,
                      text: "Usa",
                      onTap: () {
                        setState(() {
                          Provider.of<IndexSelected>(context, listen: false)
                              .setIndex(1);
                          onTap(selected.getIndex());
                        });
                        BlocProvider.of<DrawerBloc>(context)
                            .add(DrawerEvents.UsaEvent);
                      },
                    ),
                    SidebarItem(
                      key: _accountKey,
                      isSelected: selectedIndex == 2,
                      text: "History",
                      onTap: () {
                        setState(() {
                          Provider.of<IndexSelected>(context, listen: false)
                              .setIndex(2);
                          onTap(selected.getIndex());
                        });
                        BlocProvider.of<DrawerBloc>(context)
                            .add(DrawerEvents.HistoryEvent);
                      },
                    ),
                    SidebarItem(
                      key: _settingsKey,
                      isSelected: selectedIndex == 3,
                      text: "Global",
                      onTap: () {
                        setState(() {
                          Provider.of<IndexSelected>(context, listen: false)
                              .setIndex(3);
                          onTap(selected.getIndex());
                        });
                        BlocProvider.of<DrawerBloc>(context)
                            .add(DrawerEvents.GlobalEvent);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      renderBox = _homeKey.currentContext.findRenderObject();
      yPosition = renderBox.localToGlobal(Offset.zero).dy;
    });
  }
}

class SidebarClipper extends CustomClipper<Path> {
  final double startPosition, endPosition;

  SidebarClipper(this.startPosition, this.endPosition);
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(width, 0);
    path.quadraticBezierTo(width / 3, 5, width / 3, 70);

    path.lineTo(width / 3, startPosition);
    path.quadraticBezierTo(
        width / 3 - 2, startPosition + 15, width / 3 - 10, startPosition + 25);
    path.quadraticBezierTo(0, startPosition + 45, 0, startPosition + 60);
    path.quadraticBezierTo(
        0, endPosition - 45, width / 3 - 10, endPosition - 25);
    path.quadraticBezierTo(
        width / 3 - 2, endPosition - 15, width / 3, endPosition);
    path.lineTo(width / 3, endPosition);

    path.lineTo(width / 3, height - 70);
    path.quadraticBezierTo(width / 3, height - 5, width, height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
