class MyRidesDetailsModel {
  List<Result>? result;

  MyRidesDetailsModel({this.result});

  MyRidesDetailsModel.fromJson(Map<String, dynamic> json) {
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
  List<Ride>? ride;
  List<Ridelist>? ridelist;

  Result({this.ride, this.ridelist});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['ride'] != null) {
      ride = <Ride>[];
      json['ride'].forEach((v) {
        ride!.add(new Ride.fromJson(v));
      });
    }
    if (json['ridelist'] != null) {
      ridelist = <Ridelist>[];
      json['ridelist'].forEach((v) {
        ridelist!.add(new Ridelist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ride != null) {
      data['ride'] = this.ride!.map((v) => v.toJson()).toList();
    }
    if (this.ridelist != null) {
      data['ridelist'] = this.ridelist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ride {
  String? id;
  String? rideId;
  String? userId;
  String? dropLat;
  String? dropLong;
  String? rideDate;
  String? returnDate;
  String? rideAmount;
  String? amountToBePaid;
  Null? amountPaid;
  String? payType;
  String? payStatus;
  String? rideStatus;
  String? cabType;
  String? otp;
  Null? activeStatus;
  String? package;
  String? distance;
  String? hour;
  String? km;
  String? price;

  Ride(
      {this.id,
      this.rideId,
      this.userId,
      this.dropLat,
      this.dropLong,
      this.rideDate,
      this.returnDate,
      this.rideAmount,
      this.amountToBePaid,
      this.amountPaid,
      this.payType,
      this.payStatus,
      this.rideStatus,
      this.cabType,
      this.otp,
      this.activeStatus,
      this.package,
      this.distance,
      this.hour,
      this.km,
      this.price});

  Ride.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rideId = json['ride_id'];
    userId = json['user_id'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
    rideDate = json['ride_date'];
    returnDate = json['return_date'];
    rideAmount = json['ride_amount'];
    amountToBePaid = json['amount_to_be_paid'];
    amountPaid = json['amount_paid'];
    payType = json['pay_type'];
    payStatus = json['pay_status'];
    rideStatus = json['ride_status'];
    cabType = json['cab_type'];
    otp = json['otp'];
    activeStatus = json['active_status'];
    package = json['package'];
    distance = json['distance'];
    hour = json['hour'];
    km = json['km'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ride_id'] = this.rideId;
    data['user_id'] = this.userId;
    data['drop_lat'] = this.dropLat;
    data['drop_long'] = this.dropLong;
    data['ride_date'] = this.rideDate;
    data['return_date'] = this.returnDate;
    data['ride_amount'] = this.rideAmount;
    data['amount_to_be_paid'] = this.amountToBePaid;
    data['amount_paid'] = this.amountPaid;
    data['pay_type'] = this.payType;
    data['pay_status'] = this.payStatus;
    data['ride_status'] = this.rideStatus;
    data['cab_type'] = this.cabType;
    data['otp'] = this.otp;
    data['active_status'] = this.activeStatus;
    data['package'] = this.package;
    data['distance'] = this.distance;
    data['hour'] = this.hour;
    data['km'] = this.km;
    data['price'] = this.price;
    return data;
  }
}

class Ridelist {
  String? ridelistid;
  String? rideId;
  String? rideLocation;
  String? pickupLat;
  String? pickupLng;
  String? status;

  Ridelist(
      {this.ridelistid,
      this.rideId,
      this.rideLocation,
      this.pickupLat,
      this.pickupLng,
      this.status});

  Ridelist.fromJson(Map<String, dynamic> json) {
    ridelistid = json['ridelistid'];
    rideId = json['ride_id'];
    rideLocation = json['ride_location'];
    pickupLat = json['pickup_lat'];
    pickupLng = json['pickup_lng'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ridelistid'] = this.ridelistid;
    data['ride_id'] = this.rideId;
    data['ride_location'] = this.rideLocation;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_lng'] = this.pickupLng;
    data['status'] = this.status;
    return data;
  }
}
