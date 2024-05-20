import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final List<TimingsEntity>? timings;
  final String? currentDay;
  final HijriDateEntity? hijriDateEntity;


  const HomeEntity({
        this.timings,
        this.currentDay,
        this.hijriDateEntity,

      });

  @override
  List<Object?> get props => [timings, currentDay, hijriDateEntity];
}

class TimingsEntity extends HomeEntity {
  final String? salatName;
  final String? salatTime;

  const TimingsEntity({
    this.salatName,
    this.salatTime,
  });
}

class HijriDateEntity extends HomeEntity {
  final String? date;
  final String? day;

  final HijriMonthEntity? hijriMonth;
  final String? year;
  final List<String>? holidays;

  const HijriDateEntity({
    this.date,
    this.day,
    this.hijriMonth,
    this.year,
    this.holidays,
  });
}

class HijriMonthEntity extends HomeEntity {
  final int? number;
  final String? enName;
  final String? arName;

  const HijriMonthEntity({
    this.number,
    this.enName,
    this.arName,
  });
}
