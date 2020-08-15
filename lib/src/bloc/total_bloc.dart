import 'package:covid19/src/model/total_model.dart';
import 'package:covid19/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class TotalBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<TotalModel> _subject = BehaviorSubject<TotalModel>();

  getTotal() async {
    TotalModel response = await _repository.getTotal();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<TotalModel> get subject => _subject;
}

final totalBloc = TotalBloc();
