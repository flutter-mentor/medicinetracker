class MedicineModel {
  late String name;
  late String effective;
  late double initPrice;
  MedicineModel({
    required this.name,
    required this.effective,
    required this.initPrice,
  });
  MedicineModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    effective = json['effective'];
    initPrice = json['initPrice'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'effective': effective,
      'initPrice': initPrice,
    };
  }
}
