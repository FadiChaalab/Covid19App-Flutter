class TotalModel {
  final int cases,
      todayCases,
      deaths,
      todayDeaths,
      recovered,
      active,
      critical,
      casesPerOneMillion,
      deathsPerOnMillion,
      tests,
      testsPerOnMillion;

  TotalModel(
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOnMillion,
      this.tests,
      this.testsPerOnMillion);
  TotalModel.fromJson(Map<String, dynamic> json)
      : cases = json["cases"],
        todayCases = json["todayCases"],
        deaths = json["deaths"],
        todayDeaths = json["todayDeaths"],
        recovered = json["recovered"],
        active = json["active"],
        critical = json["critical"],
        casesPerOneMillion = json["casesPerOneMillion"],
        deathsPerOnMillion = json["deathsPerOnMillion"],
        tests = json["tests"],
        testsPerOnMillion = json["testsPerOnMillion"];
}
