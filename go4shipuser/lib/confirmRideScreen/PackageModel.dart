class PackageModel {
  List<Result>? result;

  PackageModel({this.result});

  PackageModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? cabid;
  String? hour;
  String? km;
  String? price;
  String? id;
  String? status;
  String? chargeForAdditionalTime;
  String? chargeForAdditionalDist;

  Result(
      {this.cabid,
        this.hour,
        this.km,
        this.price,
        this.id,
        this.status,
        this.chargeForAdditionalTime,
        this.chargeForAdditionalDist});

  Result.fromJson(Map<String, dynamic> json) {
    cabid = json['cabid'];
    hour = json['hour'];
    km = json['km'];
    price = json['price'];
    id = json['id'];
    status = json['status'];
    chargeForAdditionalTime = json['charge_for_additional_time'];
    chargeForAdditionalDist = json['charge_for_additional_dist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cabid'] = this.cabid;
    data['hour'] = this.hour;
    data['km'] = this.km;
    data['price'] = this.price;
    data['id'] = this.id;
    data['status'] = this.status;
    data['charge_for_additional_time'] = this.chargeForAdditionalTime;
    data['charge_for_additional_dist'] = this.chargeForAdditionalDist;
    return data;
  }
}
