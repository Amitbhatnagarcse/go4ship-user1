class CabListModel {
  List<Result>? result;

  CabListModel({this.result});

  CabListModel.fromJson(Map<String, dynamic> json) {
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
  List<Cabtypes>? cabtypes;
  List<Paypal>? paypal;

  Result({this.cabtypes, this.paypal});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['cabtypes'] != null) {
      cabtypes = <Cabtypes>[];
      json['cabtypes'].forEach((v) {
        cabtypes!.add(new Cabtypes.fromJson(v));
      });
    }
    if (json['paypal'] != null) {
      paypal = <Paypal>[];
      json['paypal'].forEach((v) {
        paypal!.add(new Paypal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cabtypes != null) {
      data['cabtypes'] = this.cabtypes!.map((v) => v.toJson()).toList();
    }
    if (this.paypal != null) {
      data['paypal'] = this.paypal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cabtypes {
  String? cabtype;
  String? id;
  Null? seats;
  String? logoUrl;
  Null? pointtopointFare;
  Null? rentalFare;
  Null? outstationOneway;
  String? outstationRoundtrip;
  String? outstationWaiting;
  String? outstationAllowance;

  Cabtypes(
      {this.cabtype,
        this.id,
        this.seats,
        this.logoUrl,
        this.pointtopointFare,
        this.rentalFare,
        this.outstationOneway,
        this.outstationRoundtrip,
        this.outstationWaiting,
        this.outstationAllowance});

  Cabtypes.fromJson(Map<String, dynamic> json) {
    cabtype = json['cabtype'];
    id = json['id'];
    seats = json['seats'];
    logoUrl = json['logo_url'];
    pointtopointFare = json['pointtopoint_fare'];
    rentalFare = json['rental_fare'];
    outstationOneway = json['outstation_oneway'];
    outstationRoundtrip = json['outstation_roundtrip'];
    outstationWaiting = json['outstation_waiting'];
    outstationAllowance = json['outstation_allowance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cabtype'] = this.cabtype;
    data['id'] = this.id;
    data['seats'] = this.seats;
    data['logo_url'] = this.logoUrl;
    data['pointtopoint_fare'] = this.pointtopointFare;
    data['rental_fare'] = this.rentalFare;
    data['outstation_oneway'] = this.outstationOneway;
    data['outstation_roundtrip'] = this.outstationRoundtrip;
    data['outstation_waiting'] = this.outstationWaiting;
    data['outstation_allowance'] = this.outstationAllowance;
    return data;
  }
}

class Paypal {
  String? apikey;
  String? env;
  String? currency;
  Null? wallet;

  Paypal({this.apikey, this.env, this.currency, this.wallet});

  Paypal.fromJson(Map<String, dynamic> json) {
    apikey = json['apikey'];
    env = json['env'];
    currency = json['currency'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apikey'] = this.apikey;
    data['env'] = this.env;
    data['currency'] = this.currency;
    data['wallet'] = this.wallet;
    return data;
  }
}
