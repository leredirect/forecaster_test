import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../consts.dart';

class CurrentWeather {
  CurrentWeather({
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    required this.currentRain,
  });

  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  CurrentSys sys;
  int timezone;
  int id;
  String name;
  int cod;
  CurrentRain currentRain;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromJson(json["wind"]),
        clouds: Clouds.fromJson(json["clouds"]),
        dt: json["dt"],
        sys: CurrentSys.fromJson(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
        currentRain: CurrentRain.fromJson(
            json["rain"] ?? <String, dynamic>{"3h": 0.0, "1h": 0.0}),
      );

  Map<String, dynamic> toJson() => {

        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "base": base,
        "main": main.toJson(),
        "visibility": visibility,
        "wind": wind.toJson(),
        "clouds": clouds.toJson(),
        "dt": dt,
        "sys": sys.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };

  static Future<Response> fetchCurrentWeather(double lat, double lon) async {
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=' + lat.toString() + '&lon=' + lon.toString() + '&' + openWeatherMapApiKey + '&units=metric'));
    print(response.statusCode);
    print(response.body);
    return response;
  }
}

class CurrentRain {
  CurrentRain({
    required this.the1H,
    required this.the3H,
  });

  var the3H;
  var the1H;

  factory CurrentRain.fromJson(Map<String, dynamic> json) => CurrentRain(
        the3H: json["3h"] ?? 0.0,
        the1H: json["1h"] ?? 0.0,
      );

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

  var temp;
  var feelsLike;
  var tempMin;
  var tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"]?? 0,
        tempMin: json["temp_min"]?? 0,
        tempMax: json["temp_max"]?? 0,
        pressure: json["pressure"]?? 0,
        humidity: json["humidity"]?? 0,
        seaLevel: json["sea_level"]?? 0,
        grndLevel: json["grnd_level"]?? 0,
      );

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

  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  factory CurrentSys.fromJson(Map<String, dynamic> json) => CurrentSys(
        type: json["type"] ?? 0,
        id: json["id"] ?? 0,
        country: json["country"] ?? "No Country",
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

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

  String cod;
  int message;
  int cnt;
  List<ListElement> list;
  City city;

  static Future<Response> fetchForecasts(double lat, double lon) async {
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=' + lat.toString() + '&lon=' + lon.toString() + '&' + openWeatherMapApiKey + '&units=metric'));
    print(response.statusCode);
    print(response.body);
    return response;
  }

  factory ForecastsList.fromJson(Map<String, dynamic> json) => ForecastsList(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        city: City.fromJson(json["city"]),
      );

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

  int id;
  String name;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

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
    // required this.rain,
  });

  int dt;
  MainClass main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  var pop;
  Sys sys;
  DateTime dtTxt;

  //Rain rain;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: MainClass.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"]?? 0,
        sys: Sys.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
        //rain: json["rain"] ?? Rain(the3H: 0),
      );

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
        // "rain": rain.toJson(),
      };
}

class Clouds {
  Clouds({
    required this.all,
  });

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

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

  var temp;
  var feelsLike;
  var tempMin;
  var tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  var tempKf;

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"]?? 0,
        tempMin: json["temp_min"]?? 0,
        tempMax: json["temp_max"]?? 0,
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"]?? 0,
      );

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

  double the3H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H: json["3h"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "3h": the3H,
      };
}

class Sys {
  Sys({
    required this.pod,
  });

  Pod pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: podValues.map[json["pod"]]!,
      );

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
  });

  int id;
  String main;
  String description;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      id: json["id"], main: json["main"]!, description: json["description"]!);

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainEnumValues.reverse[main],
        "description": descriptionValues.reverse[description],
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

enum IconList { THE_03_D, THE_04_N, THE_04_D, THE_10_D, THE_01_N, THE_10_N }

final iconValues = EnumValues({
  "01n": IconList.THE_01_N,
  "03d": IconList.THE_03_D,
  "04d": IconList.THE_04_D,
  "04n": IconList.THE_04_N,
  "10d": IconList.THE_10_D,
  "10n": IconList.THE_10_N
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

  var speed;
  int deg;
  var gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?? 0,
        deg: json["deg"],
        gust: json["gust"]?? 0,
      );

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
