import 'package:flutter/material.dart';

class CustomModel {
  Map<String, dynamic> ?customValues;
  String ?role;
  String? comment;
  int? statusCode;
  String? updatedBy;
  int ?id;
  bool ?deleted;
  DateTime? updatedAt;
  DateTime ?createdAt;
  String ?createdBy;
  int ?parentBusinessRelationID;
  int ?infoID;

  CustomModel({
    this.customValues,
    this.role,
    this.comment,
    this.statusCode,
    this.updatedBy,
    this.id,
    this.deleted,
    this.updatedAt,
    this.createdAt,
    this.createdBy,
    this.parentBusinessRelationID,
    this.infoID,
  });

  factory CustomModel.fromJson(Map<String, dynamic> json) {
    return CustomModel(
      customValues: json['CustomValues'] ?? {},
      role: json['Role'],
      comment: json['Comment'],
      statusCode: json['StatusCode'],
      updatedBy: json['UpdatedBy'],
      id: json['ID'],
      deleted: json['Deleted'],
      updatedAt: json['UpdatedAt'] != null ? DateTime.parse(json['UpdatedAt']) : null,
      createdAt: DateTime.parse(json['CreatedAt']),
      createdBy: json['CreatedBy'],
      parentBusinessRelationID: json['ParentBusinessRelationID'],
      infoID: json['InfoID'],
    );
  }
}