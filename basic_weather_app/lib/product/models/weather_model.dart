class ApiResponse {
  Location? location;
  Current? current;

  ApiResponse({this.location, this.current});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    current =
    json['current'] != null ?  Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}

class Location {
  String? name;
  String? country;
  String? localtime;

  Location({this.name, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    data['localtime'] = localtime;
    return data;
  }
}

class Current {
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  double? precipMm;
  int? humidity;
  int? uv;

  Current(
      {this.tempC,
        this.isDay,
        this.condition,
        this.windKph,
        this.precipMm,
        this.humidity,
        this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ?  Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    precipMm = json['precip_mm'];
    humidity = json['humidity'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['temp_c'] = tempC;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_kph'] = windKph;
    data['precip_mm'] = precipMm;
    data['humidity'] = humidity;
    data['uv'] = uv;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['text'] = text;
    data['icon'] = icon;
    data['code'] = code;
    return data;
  }
}