import 'package:covid19/src/model/historic_response.dart';
import 'package:covid19/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class HistoricBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<HistoricResponse> _subject =
      BehaviorSubject<HistoricResponse>();

  getHistoric() async {
    HistoricResponse response = await _repository.getHistoric();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<HistoricResponse> get subject => _subject;
}

final historicBloc = HistoricBloc();
