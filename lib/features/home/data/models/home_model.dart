import '../../domain/entities/home.dart';

class HomeModel extends HomeEntity {
  const HomeModel(
      {
      List<TimingsEntity>? timings,
      String? currentDay,
      HijriDateModel? hijriDateModel})
      : super(

          timings: timings,
          currentDay: currentDay,
          hijriDateEntity: hijriDateModel,
        );

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      timings: (json['timings'] as Map<String, dynamic>).entries.map((entry) => TimingsModel.fromJsonEntry(entry)).toList(),
      currentDay: json['date']['readable'],
      hijriDateModel: HijriDateModel.fromJson(json['date']['hijri']),
    );
  }

  factory HomeModel.fromEntity(HomeEntity homeEntity) {
    return HomeModel(
      timings: homeEntity.timings,
      currentDay: homeEntity.currentDay,
    );
  }
}


class TimingsModel extends TimingsEntity {
  const TimingsModel({
    String? salatName,
    String? salatTime,
  }) : super(
          salatName: salatName,
          salatTime: salatTime,
        );

  factory TimingsModel.fromJsonEntry(MapEntry json) {
    return TimingsModel(
      salatTime: json.value,
      salatName: json.key,
    );
  }

  factory TimingsModel.fromEntity(TimingsEntity entity) {
    return TimingsModel(
      salatTime: entity.salatTime,
      salatName: entity.salatName,
    );
  }
}

class HijriDateModel extends HijriDateEntity {
  const HijriDateModel(
      {String? date,
      String? day,
      HijriMonthModel? hijriMonth,
      String? year,
      List<String>? holidays})
      : super(date: date, day: day, hijriMonth: hijriMonth, year: year, holidays: holidays);

  factory HijriDateModel.fromJson(Map json) {
    List<String> holidays = [];
    if(json.containsKey("holidays")){
      if(json['holidays']!=null|| json['holidays'].isNotEmpty){
        for(var item in json['holidays']){
          holidays.add(item);
        }
      }
    }

    return HijriDateModel(
      date: json['date'],
      day: json['day'],
      hijriMonth: HijriMonthModel.fromJson(json['month']),
      year: json['year'],
      holidays: holidays,
    );
  }
}

class HijriMonthModel extends HijriMonthEntity {
  const HijriMonthModel({int? number, String? enName, String? arName})
      : super(
          number: number,
          enName: enName,
          arName: arName,
        );

  factory HijriMonthModel.fromJson(Map json) {
    return HijriMonthModel(number: json['number'], enName: json['en'], arName: json['ar']);
  }

  factory HijriMonthModel.fromEntity(HijriMonthEntity entity) {
    return HijriMonthModel(number: entity.number, enName: entity.enName, arName: entity.arName);
  }
}
