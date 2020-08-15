import 'package:covid19/src/model/state_response.dart';
import 'package:covid19/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class StateBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<StateResponse> _subject =
      BehaviorSubject<StateResponse>();

  getStates() async {
    StateResponse response = await _repository.getStates();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<StateResponse> get subject => _subject;
}

final stateBloc = StateBloc();
