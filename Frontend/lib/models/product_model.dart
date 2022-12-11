class Product {
  Product({
    this.pharmacyId,
    this.name,
    this.schedule,
    this.positionX,
    this.positionY,
    this.drugName,
    this.price,
  });

  Product.fromJson(Map<String, dynamic> json) {
    pharmacyId = json['pharmacyId'] as int;
    name = json['name'] as String;
    positionX = json['positionX'] as double;
    positionY = json['positionY'] as double;
    price = json['price'] as int;
  }
  int? pharmacyId;
  String? name;
  String? schedule;
  double? positionX;
  double? positionY;
  String? drugName;
  int? price;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pharmacyId'] = pharmacyId;
    data['name'] = name;
    data['schedule'] = schedule;
    data['positionX'] = positionX;
    data['positionY'] = positionY;
    data['drugName'] = drugName;
    data['price'] = price;
    return data;
  }
}
