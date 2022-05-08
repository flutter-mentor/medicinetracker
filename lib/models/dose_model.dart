import 'package:cloud_firestore/cloud_firestore.dart';

class DoseModel {
  late String medName;
  late String hint;
  late int taken;
  late int interval;
  late Timestamp createdAt;
  late int id;
  late String payload;
  late List intakes;
  DoseModel({
    required this.medName,
    required this.interval,
    required this.taken,
    required this.createdAt,
    required this.id,
    required this.payload,
    required this.hint,
    required this.intakes,
  });
  DoseModel.fromJson(Map<String, dynamic> json) {
    medName = json['medName'];
    taken = json['taken'];
    interval = json['interval'];
    createdAt = json['createdAt'];
    hint = json['hint'];
    payload = json['payload'];
    id = json['id'];
    intakes = json['intakes'];
  }
  Map<String, dynamic> toMap() {
    return {
      'medName': medName,
      'taken': taken,
      'interval': interval,
      'createdAt': createdAt,
      'id': id,
      'hint': hint,
      'intakes': intakes,
    };
  }
}
