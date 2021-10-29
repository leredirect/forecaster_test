class CurrentWeather {
  CurrentWeather({
    required this.currentMetaInfo,
    required this.base,
    required this.currentBaseInfo,
    required this.visibility,
    required this.currentWind,
    required this.currentClouds,
    required this.dt,
    required this.currentSys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    required this.currentRain,
  });

  late List<CurrentMetaInfo> currentMetaInfo;
  late String base;
  late CurrentBaseInfo currentBaseInfo;
  late int visibility;
  late CurrentWind currentWind;
  late CurrentClouds currentClouds;
  late int dt;
  late CurrentSys currentSys;
  late int timezone;
  late int id;
  late String name;
  late int cod;
  late CurrentRain currentRain;

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    currentMetaInfo = List<CurrentMetaInfo>.from(
        json["weather"].map((x) => CurrentMetaInfo.fromJson(x)));
    base = json["base"];
    currentBaseInfo = CurrentBaseInfo.fromJson(json["main"]);
    visibility = json["visibility"];
    currentWind = CurrentWind.fromJson(json["wind"]);
    currentClouds = CurrentClouds.fromJson(json["clouds"]);
    dt = json["dt"];
    currentSys = CurrentSys.fromJson(json["sys"]);
    timezone = json["timezone"];
    id = json["id"];
    name = json["name"];
    cod = json["cod"];
    currentRain = CurrentRain.fromJson(
        json["rain"] ?? <String, dynamic>{"3h": 0.0, "1h": 0.0});
  }
}

class CurrentClouds {
  CurrentClouds({
    required this.all,
  });

  late int all;

  CurrentClouds.fromJson(Map<String, dynamic> json) {
    all = json["all"];
  }
}

class CurrentRain {
  CurrentRain({
    required this.the1H,
    required this.the3H,
  });

  late double the3H;
  late double the1H;

  CurrentRain.fromJson(Map<String, dynamic> json) {
    if (json["3H"] != null && json["1H"] != null) {
      the3H = json["3H"].toDouble();
      the1H = json["1H"].toDouble();
    } else {
      the3H = 0.0;
      the1H = 0.0;
    }
  }
}

class CurrentBaseInfo {
  CurrentBaseInfo({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  late double temp;
  late double feelsLike;
  late double tempMin;
  late double tempMax;
  late int pressure;
  late int humidity;
  late int seaLevel;
  late int grndLevel;

  CurrentBaseInfo.fromJson(Map<String, dynamic> json) {
    temp = json["temp"].toDouble();
    feelsLike = json["feels_like"].toDouble();
    tempMin = json["temp_min"].toDouble();
    tempMax = json["temp_max"].toDouble();
    pressure = json["pressure"] ?? 0;
    humidity = json["humidity"] ?? 0;
    seaLevel = json["sea_level"] ?? 0;
    grndLevel = json["grnd_level"] ?? 0;
  }
}

class CurrentSys {
  CurrentSys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  late int type;
  late int id;
  late String country;
  late int sunrise;
  late int sunset;

  CurrentSys.fromJson(Map<String, dynamic> json) {
    type = json["type"] ?? 0;
    id = json["id"] ?? 0;
    country = json["country"] ?? "No Country";
    sunrise = json["sunrise"];
    sunset = json["sunset"];
  }
}

class CurrentWind {
  CurrentWind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  late double speed;
  late int deg;
  late double gust;

  CurrentWind.fromJson(Map<String, dynamic> json) {
    speed = json["speed"].toDouble();
    deg = json["deg"];
    if (json["gust"] != null) {
      gust = json["gust"].toDouble();
    } else {
      gust = 0.0;
    }
  }

  String degreesToRoseOfWind() {
    String result = 'error';
    if (deg > 0 && deg < 45) {
      result = "N";
    } else if (deg > 45 && deg < 90) {
      result = "NE";
    } else if (deg > 90 && deg < 135) {
      result = "E";
    } else if (deg > 135 && deg < 180) {
      result = "ES";
    } else if (deg > 180 && deg < 225) {
      result = "S";
    } else if (deg > 225 && deg < 270) {
      result = "SW";
    } else if (deg > 270 && deg < 315) {
      result = "W";
    } else if (deg > 315) {
      result = "NW";
    }
    return result;
  }
}

class CurrentMetaInfo {
  CurrentMetaInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  late int id;
  late String main;
  late String description;
  late String icon;

  CurrentMetaInfo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"]!;
    description = json["description"]!;
    icon = json["icon"];
  }
}
