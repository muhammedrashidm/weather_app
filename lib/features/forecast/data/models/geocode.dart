// To parse this JSON data, do
//
//     final geoCode = geoCodeFromJson(jsonString);

import 'dart:convert';

import 'package:my_weather/features/forecast/domain/entities/geocode.dart';

GeoCode geoCodeFromJson(String str) => GeoCodeModel.fromJson(json.decode(str));

String geoCodeToJson(GeoCodeModel data) => json.encode(data.toJson());

class GeoCodeModel extends GeoCode {
  final int? placeId;
  final String? licence;
  final String? osmType;
  final int? osmId;
  final String? lat;
  final String? lon;
  final String? displayName;
  final AddressModel? address;
  final List<String>? boundingbox;

  GeoCodeModel({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.displayName,
    this.address,
    this.boundingbox,
  }) : super(
            placeId: 0,
            licence: '',
            osmType: '',
            osmId: 0,
            lat: '',
            lon: '',
            displayName: '',
            address: address,
            boundingbox: null);

  factory GeoCodeModel.fromJson(Map<String, dynamic> json) => GeoCodeModel(
        placeId: json["place_id"],
        licence: json["licence"],
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        lat: json["lat"],
        lon: json["lon"],
        displayName: json["display_name"],
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        boundingbox: json["boundingbox"] == null
            ? []
            : List<String>.from(json["boundingbox"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "display_name": displayName,
        "address": address?.toJson(),
        "boundingbox": boundingbox == null
            ? []
            : List<dynamic>.from(boundingbox!.map((x) => x)),
      };
}

class AddressModel extends Address {
  final String? junction;
  final String? road;
  final String? suburb;
  final String? city;
  final String? county;
  final String? stateDistrict;
  final String? state;
  final String? iso31662Lvl4;
  final String? postcode;
  final String? country;
  final String? countryCode;

  AddressModel({
    this.junction,
    this.road,
    this.suburb,
    this.city,
    this.county,
    this.stateDistrict,
    this.state,
    this.iso31662Lvl4,
    this.postcode,
    this.country,
    this.countryCode,
  }) : super(
            junction: '',
            road: '',
            suburb:suburb ,
            city: city,
            county: '',
            stateDistrict: stateDistrict,
            state: '',
            iso31662Lvl4: '',
            postcode: '',
            country: '',
            countryCode: countryCode ?? '');

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        junction: json["junction"],
        road: json["road"],
        suburb: json["suburb"],
        city: json["city"],
        county: json["county"],
        stateDistrict: json["state_district"],
        state: json["state"],
        iso31662Lvl4: json["ISO3166-2-lvl4"],
        postcode: json["postcode"],
        country: json["country"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "junction": junction,
        "road": road,
        "suburb": suburb,
        "city": city,
        "county": county,
        "state_district": stateDistrict,
        "state": state,
        "ISO3166-2-lvl4": iso31662Lvl4,
        "postcode": postcode,
        "country": country,
        "country_code": countryCode,
      };
}
