import 'package:intl/intl.dart';

class MassageEntity {
  int id;
  DateTime createdTime;
  String useTime;

  MassageEntity(
      {required this.id, required this.createdTime, required this.useTime});

  factory MassageEntity.fromJson(Map<String, dynamic> json) {
    return MassageEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      useTime: json['useTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'useTime': useTime,
    };
  }

  String get createdTimeStr => DateFormat('MM/dd/yyyy').format(createdTime);
}
