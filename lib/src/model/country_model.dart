class CountryModel {
  final String country, countryIso, flag;
  final int active,
      cases,
      todayDeaths,
      deaths,
      recovered,
      todayCases,
      critical,
      casesPerOnMillion,
      deathsPerOnMillion,
      tests,
      testsPerOnMillion;

  CountryModel(
      this.country,
      this.countryIso,
      this.flag,
      this.active,
      this.cases,
      this.todayDeaths,
      this.deaths,
      this.recovered,
      this.todayCases,
      this.critical,
      this.casesPerOnMillion,
      this.deathsPerOnMillion,
      this.tests,
      this.testsPerOnMillion);

  CountryModel.fromJson(Map<String, dynamic> json)
      : country = json["country"],
        countryIso = json["countryInfo"]["iso2"],
        flag = json["countryInfo"]["flag"],
        active = json["active"],
        cases = json["cases"],
        todayDeaths = json["todayDeaths"],
        deaths = json["deaths"],
        recovered = json["recovered"],
        todayCases = json["todayCases"],
        critical = json["critical"],
        casesPerOnMillion = json["casesPerOnMillion"],
        deathsPerOnMillion = json["deathsPerOnMillion"],
        tests = json["tests"],
        testsPerOnMillion = json["testsPerOnMillion"];
}
