import 'package:covid19/src/model/state_model.dart';

class StateResponse {
  final List<StateModel> states;
  final String error;

  StateResponse(this.states, this.error);

  StateResponse.fromJson(List<dynamic> json)
      : states = json.map((i) => new StateModel.fromJson(i)).toList(),
        error = "";
  StateResponse.withError(String value)
      : states = List(),
        error = value;
}
