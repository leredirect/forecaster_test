enum ForecasterIconList {
  the_01d,
  the_02d,
  the_03d,
  the_04d,
  the_09d,
  the_10d,
  the_11d,
  the_13d,
  the_50d,
  the_01n,
  the_02n,
  the_03n,
  the_04n,
  the_09n,
  the_10n,
  the_11n,
  the_13n,
  the_50n
}

class ForecastsList {
  ForecastsList({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.forecastBaseInfoList,
    required this.forecastLocationInfo,
  });

  late String cod;
  late int message;
  late int cnt;
  late List<ForecastBaseInfo> forecastBaseInfoList;
  late ForecastLocationInfo forecastLocationInfo;

  ForecastsList.fromJson(Map<String, dynamic> json) {
    cod = json["cod"];
    message = json["message"];
    cnt = json["cnt"];
    forecastBaseInfoList = List<ForecastBaseInfo>.from(
        json["list"].map((x) => ForecastBaseInfo.fromJson(x)));
    forecastLocationInfo = ForecastLocationInfo.fromJson(json["city"]);
  }
}

class ForecastLocationInfo {
  ForecastLocationInfo({
    required this.id,
    required this.name,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  late int id;
  late String name;
  late String country;
  late int population;
  late int timezone;
  late int sunrise;
  late int sunset;

  ForecastLocationInfo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    country = json["country"];
    population = json["population"];
    timezone = json["timezone"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
  }
}

class ForecastBaseInfo {
  ForecastBaseInfo({
    required this.dt,
    required this.forecastConditions,
    required this.forecastMetaInfoList,
    required this.forecastCloud,
    required this.forecastWind,
    required this.visibility,
    required this.pop,
    required this.forecastSys,
    required this.dtTxt,
  });

  late int dt;
  late ForecastConditions forecastConditions;
  late List<ForecastMetaInfo> forecastMetaInfoList;
  late ForecastClouds forecastCloud;
  late ForecastWind forecastWind;
  late int visibility;
  late double pop;
  late ForecastSys forecastSys;
  late DateTime dtTxt;

  ForecastBaseInfo.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    forecastConditions = ForecastConditions.fromJson(json["main"]);
    forecastMetaInfoList = List<ForecastMetaInfo>.from(
        json["weather"].map((x) => ForecastMetaInfo.fromJson(x)));
    forecastCloud = ForecastClouds.fromJson(json["clouds"]);
    forecastWind = ForecastWind.fromJson(json["wind"]);
    visibility = json["visibility"];
    pop = json["pop"].toDouble();
    forecastSys = ForecastSys.fromJson(json["sys"]);
    dtTxt = DateTime.parse(json["dt_txt"]);
  }
}

class ForecastClouds {
  ForecastClouds({
    required this.all,
  });

  late int all;

  ForecastClouds.fromJson(Map<String, dynamic> json) {
    all = json["all"];
  }

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class ForecastConditions {
  ForecastConditions({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  late double temp;
  late double feelsLike;
  late double tempMin;
  late double tempMax;
  late int pressure;
  late int seaLevel;
  late int grndLevel;
  late int humidity;
  late double tempKf;

  ForecastConditions.fromJson(Map<String, dynamic> json) {
    temp = json["temp"].toDouble();
    feelsLike = json["feels_like"].toDouble();
    tempMin = json["temp_min"].toDouble();
    tempMax = json["temp_max"].toDouble();
    pressure = json["pressure"];
    seaLevel = json["sea_level"];
    grndLevel = json["grnd_level"];
    humidity = json["humidity"];
    tempKf = json["temp_kf"].toDouble();
  }

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
      };
}

class ForecastRain {
  ForecastRain({
    required this.the3H,
  });

  late double the3H;

  ForecastRain.fromJson(Map<String, dynamic> json) {
    if (json["3h"] != null) {
      the3H = json["3h"].toDouble();
    } else {
      the3H = 0.0;
    }
  }
}

class ForecastSys {
  ForecastSys({
    required this.pod,
  });

  late Pod pod;

  ForecastSys.fromJson(Map<String, dynamic> json) {
    pod = podValues.map[json["pod"]]!;
  }
}

class ForecastMetaInfo {
  ForecastMetaInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  late int id;
  late String main;
  late String description;
  late String icon;

  ForecastMetaInfo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"]!;
    description = json["description"]!;
    icon = json["icon"];
  }
}

class ForecastWind {
  ForecastWind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  late double speed;
  late int deg;
  late double gust;

  ForecastWind.fromJson(Map<String, dynamic> json) {
    speed = json["speed"].toDouble();
    deg = json["deg"];
    if (json["gust"] != null) {
      gust = json["gust"].toDouble();
    } else {
      gust = 0.0;
    }
  }
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}

enum Pod { D, N }

final podValues = EnumValues({"d": Pod.D, "n": Pod.N});

enum Description {
  scatteredClouds,
  brokenClouds,
  overcastClouds,
  lightRain,
  clearSky,
  ligthSnow
}

final descriptionValues = EnumValues({
  "Broken clouds": Description.brokenClouds,
  "Clear sky": Description.clearSky,
  "Light rain": Description.lightRain,
  "Overcast clouds": Description.overcastClouds,
  "Scattered clouds": Description.scatteredClouds,
  "Light snow": Description.ligthSnow,
});
