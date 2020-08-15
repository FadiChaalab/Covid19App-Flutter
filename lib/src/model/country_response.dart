import 'package:covid19/src/model/country_model.dart';

class CountryResponse {
  final List<CountryModel> countries;
  final String error;

  CountryResponse(this.countries, this.error);

  CountryResponse.fromJson(List<dynamic> json)
      : countries = json.map((i) => new CountryModel.fromJson(i)).toList(),
        error = "";
  CountryResponse.withError(String value)
      : countries = List(),
        error = value;
}
