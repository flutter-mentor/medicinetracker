import 'package:cloud_firestore/cloud_firestore.dart';

class IntakeModel {
  late DateTime time;
  late int dose;
  IntakeModel({
    required this.time,
    required this.dose,
  });
}
