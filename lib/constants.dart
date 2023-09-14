import 'dart:ui';

import 'package:flutter/material.dart';

//Constants for the color used in the app
class ColorConstants{
  static Color DarkBlue = new Color(0xFF123F9A);
  static Color LightBlue = new Color(0xFF2699FB);
  static Color AttentionRed = new Color(0xFFE72836);
}

//User credentials
class UserCredentials{
  static String Token = '';
  static const String companyKey = String.fromEnvironment('COMPANY_KEY', defaultValue: '2767e3e2-f432-459a-a3a1-ff466f327484');
}