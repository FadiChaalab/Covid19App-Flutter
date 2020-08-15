import 'package:covid19/src/model/total_model.dart';

class TotalResponse {
  final TotalModel total;
  final String error;

  TotalResponse(this.total, this.error);

  TotalResponse.fromJson(Map<String, dynamic> json)
      : total = json["result"],
        error = "";
  TotalResponse.withError(String value)
      : total = null,
        error = value;
}
