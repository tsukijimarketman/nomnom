import 'package:flutter/material.dart';

class BusinessDetail extends StatefulWidget {
  String image, name, detail, email, password;
  BusinessDetail(
      {required this.image,
      required this.name,
      required this.detail,
      required this.email,
      required this.password});

  @override
  State<BusinessDetail> createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}