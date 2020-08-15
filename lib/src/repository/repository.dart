import 'dart:convert';
import 'package:covid19/src/model/country_response.dart';
import 'package:covid19/src/model/historic_response.dart';
import 'package:covid19/src/model/state_response.dart';
import 'package:covid19/src/model/total_model.dart';
import 'package:http/http.dart' show Client;

class Repository {
  static String mainUrl = "https://corona.lmao.ninja/v2";
  Client client = Client();
  Future<CountryResponse> getSummer() async {
    try {
      final response = await client.get("$mainUrl/countries");
      if (response.statusCode == 200) {
        return CountryResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load summary');
      }
    } catch (ex) {
      print(ex);
      throw Exception('Something went wrong, plz try later!');
    }
  }

  Future<TotalModel> getTotal() async {
    try {
      final response = await client.get("$mainUrl/all");
      if (response.statusCode == 200) {
        return TotalModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Total');
      }
    } catch (ex) {
      print(ex);
      throw Exception('Something went wrong, plz try later!');
    }
  }

  Future<StateResponse> getStates() async {
    try {
      final response = await client.get("$mainUrl/states");
      if (response.statusCode == 200) {
        return StateResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load States');
      }
    } catch (ex) {
      print(ex);
      throw Exception('Something went wrong, plz try later!');
    }
  }

  Future<HistoricResponse> getHistoric() async {
    try {
      final response = await client.get("$mainUrl/historical?lastdays=7");
      if (response.statusCode == 200) {
        return HistoricResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Historic');
      }
    } catch (ex) {
      print(ex);
      throw Exception('Something went wrong, plz try later!');
    }
  }
}
