import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

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

class CurrentWeather {
  CurrentWeather({
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.currentSys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    required this.currentRain,
  });

  late List<Weather> weather;
  late String base;
  late Main main;
  late int visibility;
  late Wind wind;
  late Clouds clouds;
  late int dt;
  late CurrentSys currentSys;
  late int timezone;
  late int id;
  late String name;
  late int cod;
  late CurrentRain currentRain;

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    weather =
        List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x)));
    base = json["base"];
    main = Main.fromJson(json["main"]);
    visibility = json["visibility"];
    wind = Wind.fromJson(json["wind"]);
    clouds = Clouds.fromJson(json["clouds"]);
    dt = json["dt"];
    currentSys = CurrentSys.fromJson(json["sys"]);
    timezone = json["timezone"];
    id = json["id"];
    name = json["name"];
    cod = json["cod"];
    currentRain = CurrentRain.fromJson(
        json["rain"] ?? <String, dynamic>{"3h": 0.0, "1h": 0.0});
  }

  Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "base": base,
        "main": main.toJson(),
        "visibility": visibility,
        "wind": wind.toJson(),
        "clouds": clouds.toJson(),
        "dt": dt,
        "sys": currentSys.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };

  static Future<Response> fetchCurrentWeather(double lat, double lon) async {
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=' +
            lat.toString() +
            '&lon=' +
            lon.toString() +
            '&' +
            openWeatherMapApiKey +
            '&units=metric'
        ));
    return response;
  }

  CurrentWeather copyWith(CurrentWeather base) {
    return CurrentWeather(
        currentRain: CurrentRain(
            the1H: base.currentRain.the1H, the3H: base.currentRain.the3H),
        visibility: base.visibility,
        base: base.base,
        id: base.id,
        cod: base.cod,
        clouds: Clouds(all: base.clouds.all),
        currentSys: CurrentSys(
            country: base.currentSys.country,
            id: base.currentSys.id,
            sunset: base.currentSys.sunset,
            type: base.currentSys.type,
            sunrise: base.currentSys.sunrise),
        main: Main(
            temp: base.main.temp,
            feelsLike: base.main.feelsLike,
            tempMin: base.main.tempMin,
            tempMax: base.main.tempMax,
            pressure: base.main.pressure,
            humidity: base.main.humidity,
            seaLevel: base.main.seaLevel,
            grndLevel: base.main.grndLevel),
        weather: base.weather,
        name: base.name,
        dt: base.dt,
        wind: Wind(
            speed: base.wind.speed, deg: base.wind.deg, gust: base.wind.gust),
        timezone: base.timezone);
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

  Map<dynamic, dynamic> toMap() {
    return {the3H: 0, the1H: 0};
  }
}

class Main {
  Main({
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

  Main.fromJson(Map<String, dynamic> json) {
    temp = json["temp"].toDouble();
    feelsLike = json["feels_like"].toDouble();
    tempMin = json["temp_min"].toDouble();
    tempMax = json["temp_max"].toDouble();
    pressure = json["pressure"] ?? 0;
    humidity = json["humidity"] ?? 0;
    seaLevel = json["sea_level"] ?? 0;
    grndLevel = json["grnd_level"] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };
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

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class ForecastsList {
  ForecastsList({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  late String cod;
  late int message;
  late int cnt;
  late List<ListElement> list;
  late City city;

  static Future<Response> fetchForecasts(double lat, double lon) async {
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=' +
            // lat.toString() +
            // '&lon=' +
            // lon.toString() +
            // '&' +
            // openWeatherMapApiKey +
            '&units=metric'
        ));
    return response;
  }

  ForecastsList.fromJson(Map<String, dynamic> json) {
    cod = json["cod"];
    message = json["message"];
    cnt = json["cnt"];
    list = List<ListElement>.from(
        json["list"].map((x) => ListElement.fromJson(x)));
    city = City.fromJson(json["city"]);
  }

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "city": city.toJson(),
      };
}

class City {
  City({
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

  City.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    country = json["country"];
    population = json["population"];
    timezone = json["timezone"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class ListElement {
  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  late int dt;
  late MainClass main;
  late List<Weather> weather;
  late Clouds clouds;
  late Wind wind;
  late int visibility;
  late double pop;
  late Sys sys;
  late DateTime dtTxt;

  ListElement.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    main = MainClass.fromJson(json["main"]);
    weather =
        List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x)));
    clouds = Clouds.fromJson(json["clouds"]);
    wind = Wind.fromJson(json["wind"]);
    visibility = json["visibility"];
    pop = json["pop"].toDouble();
    sys = Sys.fromJson(json["sys"]);
    dtTxt = DateTime.parse(json["dt_txt"]);



  }

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds.toJson(),
        "wind": wind.toJson(),
        "visibility": visibility,
        "pop": pop,
        "sys": sys.toJson(),
        "dt_txt": dtTxt.toIso8601String(),
      };
}

class Clouds {
  Clouds({
    required this.all,
  });

  late int all;

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json["all"];
  }

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class MainClass {
  MainClass({
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

  MainClass.fromJson(Map<String, dynamic> json) {
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

class Rain {
  Rain({
    required this.the3H,
  });

  late double the3H;

  Rain.fromJson(Map<String, dynamic> json) {
    if (json["3h"] != null) {
      the3H = json["3h"].toDouble();
    } else {
      the3H = 0.0;
    }
  }

  Map<String, dynamic> toJson() => {
        "3h": the3H,
      };
}

class Sys {
  Sys({
    required this.pod,
  });

  late Pod pod;

  Sys.fromJson(Map<String, dynamic> json) {
    pod = podValues.map[json["pod"]]!;
  }

  Map<String, dynamic> toJson() => {
        "pod": podValues.reverse[pod],
      };
}

enum Pod { D, N }

final podValues = EnumValues({"d": Pod.D, "n": Pod.N});

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  late int id;
  late String main;
  late String description;
  late String icon;

  Weather.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"]!;
    description = json["description"]!;
    icon = json["icon"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainEnumValues.reverse[main],
        "description": descriptionValues.reverse[description],
        "icon": icon,
      };
}

enum Description {
  SCATTERED_CLOUDS,
  BROKEN_CLOUDS,
  OVERCAST_CLOUDS,
  LIGHT_RAIN,
  CLEAR_SKY,
  LIGHT_SNOW
}

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "light rain": Description.LIGHT_RAIN,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS,
  "light snow": Description.LIGHT_SNOW,
});

enum MainEnum { CLOUDS, RAIN, CLEAR }

final mainEnumValues = EnumValues({
  "Clear": MainEnum.CLEAR,
  "Clouds": MainEnum.CLOUDS,
  "Rain": MainEnum.RAIN
});

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  late double speed;
  late int deg;
  late double gust;

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json["speed"].toDouble();
    deg = json["deg"];
    if (json["gust"] != null) {
      gust = json["gust"].toDouble();
    } else {
      gust = 0.0;
    }
  }

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
