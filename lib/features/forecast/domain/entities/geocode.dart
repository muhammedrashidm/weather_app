import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GeoCode extends Equatable{
  final int? placeId;
  final String? licence;
  final String? osmType;
  final int? osmId;
  final String? lat;
  final String? lon;
  final String? displayName;
  final Address? address;
  final List<String>? boundingbox;

  GeoCode({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.displayName,
    this.address,
    this.boundingbox,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class Address extends Equatable{
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

  Address({
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
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
