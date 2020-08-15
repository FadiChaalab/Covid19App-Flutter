class StateModel {
  final String state;
  final int active,
      cases,
      todayDeaths,
      deaths,
      todayCases,
      tests,
      testsPerOnMillion;

  StateModel(
    this.state,
    this.active,
    this.cases,
    this.todayDeaths,
    this.deaths,
    this.todayCases,
    this.tests,
    this.testsPerOnMillion,
  );

  StateModel.fromJson(Map<String, dynamic> json)
      : state = json["state"],
        active = json["active"],
        cases = json["cases"],
        todayDeaths = json["todayDeaths"],
        deaths = json["deaths"],
        todayCases = json["todayCases"],
        tests = json["tests"],
        testsPerOnMillion = json["testsPerOnMillion"];
}
