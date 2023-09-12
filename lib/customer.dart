import 'package:flutter/material.dart';

//Creating some test data

final List customers = [
  {
    "Name": "Zla Nordman",
    "Adress": "Olav Kyrre",
    "Email": "CoolEmail@hotmail.com",
    "Comment": "Nothing to note",
  },
  {
    "Name": "Tuva Nordman",
    "Adress": "Bergens Torget",
    "Email": "CoolEmail@gmail.com",
    "Comment": "A lot to note",
  }
];

/*
class UserModel {
  UserModel({
    required this.CustomValues,
    required this.PaymentTermsID,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  String CustomValues;
  String PaymentTermsID;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

}

[{CustomValues: {}, PaymentTermsID: null, IsPrivate: false, CreditDays: null, CurrencyCodeID: null, InvoiceChargeID: null,
DefaultDistributionsID: null, Deleted: false, WebUrl: , DontUseFactoring: false, AcceptableDelta4CustomerPaymentAccountID: null,
DefaultSellerID: null, DeliveryTermsID: null, BusinessRelationID: 4, AvtaleGiro: false, CreatedAt: 2023-09-11T19:23:10.51Z,
ReminderEmailAddress: null, DefaultCustomerQuoteReportID: null, CalculateInterestOnReminders: false,
CreatedBy: d6b3754c-a057-4017-b01e-b7b752d8c7cb, DefaultCustomerInvoiceReportID: null,
FactoringNumber: null, AvtaleGiroNotification: false, EInvoiceAgreementReference: null,
Localization: null, EfakturaIdentifier: null, StatusCode: 30001, OrgNumber: 925141623,
UpdatedAt: 2023-09-11T19:23:10.68Z, CustomerNumberKidAlias: null,
AcceptableDelta4CustomerPayment: 0.0, GLN: null, PeppolAddress: null,
UpdatedBy: d6b3754c-a057-4017-b01e-b7b752d8c7cb, SocialSecurityNumber: null,
DefaultCustomerOrderReportID: null, SubAccountNumberSeriesID: 6,
I/flutter (27927): DontSendReminders: false, ID: 1, CustomerNumber: 100000, DimensionsID: null}]
*/
