import 'package:bloc/bloc.dart';
import 'package:covid19/src/screen/global_screen.dart';
import 'package:covid19/src/screen/history.dart';

import 'package:covid19/src/screen/summary_screen.dart';
import 'package:covid19/src/screen/usa.dart';

enum DrawerEvents { SummaryEvent, UsaEvent, HistoryEvent, GlobalEvent }

abstract class DrawerStates {}

class DrawerBloc extends Bloc<DrawerEvents, DrawerStates> {
  @override
  DrawerStates get initialState => SummaryScreen();

  @override
  Stream<DrawerStates> mapEventToState(DrawerEvents event) async* {
    switch (event) {
      case DrawerEvents.SummaryEvent:
        yield SummaryScreen();
        break;
      case DrawerEvents.UsaEvent:
        yield USAScreen();
        break;
      case DrawerEvents.HistoryEvent:
        yield HistoryScreen();
        break;
      case DrawerEvents.GlobalEvent:
        yield GlobalScreen();
        break;
    }
  }
}
