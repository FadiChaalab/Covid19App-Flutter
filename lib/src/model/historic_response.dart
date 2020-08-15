import 'package:covid19/src/model/historic.dart';

class HistoricResponse {
  final List<Historic> historics;
  final String error;

  HistoricResponse(this.historics, this.error);

  HistoricResponse.fromJson(List<dynamic> json)
      : historics = json.map((i) => new Historic.fromJson(i)).toList(),
        error = "";
  HistoricResponse.withError(String value)
      : historics = List(),
        error = value;
}
