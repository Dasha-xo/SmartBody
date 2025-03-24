import 'package:hive/hive.dart';

part 'inbody_data.g.dart';

@HiveType(typeId: 0)
class InBodyData {
  @HiveField(0)
  final double bodyFat;
  
  @HiveField(1)
  final double muscleMass;
  
  @HiveField(2)
  final double waterLevel;
  
  @HiveField(3)
  final DateTime date;

  InBodyData({
    required this.bodyFat,
    required this.muscleMass,
    required this.waterLevel,
    required this.date,
  });
}
