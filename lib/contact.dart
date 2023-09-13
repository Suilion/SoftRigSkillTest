import 'package:flutter/material.dart';

class ApiResponse {

  int ?id;
  int ?infoId;
  Info ?info;
  String ?comment;


  ApiResponse({
    this.id,
    this.infoId,
    this.info,
    this.comment,
  });


  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      id: json['ID'],
      infoId: json['InfoID'],
      info: Info.fromJson(json['Info']),
      comment: json['Comment'],
    );
  }
}

class DefaultPhone {
  int id;
  int businessRelationId;
  String countryCode;
  String description;
  String number;
  String type;


  DefaultPhone({
    required this.id,
    required this.businessRelationId,
    required this.countryCode,
    required this.description,
    required this.number,
    required this.type,
  });


  factory DefaultPhone.fromJson(Map<String, dynamic> json) {
    return DefaultPhone(
      id: json['ID'],
      businessRelationId: json['BusinessRelationID'],
      countryCode: json['CountryCode'],
      description: json['Description'],
      number: json['Number'],
      type: json['Type'],
    );
  }
}

class DefaultEmail {
  int id;
  int businessRelationId;
  bool deleted;
  String? description;
  String emailAddress;


  DefaultEmail({
    required this.id,
    required this.businessRelationId,
    required this.deleted,
    required this.emailAddress,
    this.description,
  });

  factory DefaultEmail.fromJson(Map<String, dynamic> json) {
    return DefaultEmail(
      id: json['ID'],
      businessRelationId: json['BusinessRelationID'],
      deleted: json['Deleted'],
      description: json['Description'],
      emailAddress: json['EmailAddress'],
    );
  }
}

class InvoiceAddress {
  int id;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  int businessRelationId;
  String city;
  String country;
  String countryCode;
  String postalCode;
  String? region;

  InvoiceAddress({
    required this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    required this.businessRelationId,
    required this.city,
    required this.country,
    required this.countryCode,
    required this.postalCode,
    this.region,
  });



  factory InvoiceAddress.fromJson(Map<String, dynamic> json) {
    return InvoiceAddress(
      id: json['ID'],
      addressLine1: json['AddressLine1'],
      addressLine2: json['AddressLine2'],
      addressLine3: json['AddressLine3'],
      businessRelationId: json['BusinessRelationID'],
      city: json['City'],
      country: json['Country'],
      countryCode: json['CountryCode'],
      postalCode: json['PostalCode'],
      region: json['Region'],
    );
  }
}

class Info {
  int id;
  int defaultEmailId;
  int defaultPhoneId;
  int invoiceAddressId;
  String name;
  DefaultPhone defaultPhone;
  DefaultEmail defaultEmail;
  InvoiceAddress invoiceAddress;


  Info({
    required this.id,
    required this.defaultEmailId,
    required this.defaultPhoneId,
    required this.invoiceAddressId,
    required this.name,
    required this.defaultPhone,
    required this.defaultEmail,
    required this.invoiceAddress,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      id: json['ID'],
      defaultEmailId: json['DefaultEmailID'],
      defaultPhoneId: json['DefaultPhoneID'],
      invoiceAddressId: json['InvoiceAddressID'],
      name: json['Name'],
      defaultPhone: DefaultPhone.fromJson(json['DefaultPhone']),
      defaultEmail: DefaultEmail.fromJson(json['DefaultEmail']),
      invoiceAddress: InvoiceAddress.fromJson(json['InvoiceAddress']),
    );
  }
}