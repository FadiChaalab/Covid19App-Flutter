import 'package:covid19/src/model/country_response.dart';
import 'package:covid19/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SummaryBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<CountryResponse> _subject =
      BehaviorSubject<CountryResponse>();

  getSummary() async {
    CountryResponse response = await _repository.getSummer();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CountryResponse> get subject => _subject;
}

final summaryBloc = SummaryBloc();
