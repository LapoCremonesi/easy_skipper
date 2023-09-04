import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  Service({
    super.key,
    required this.service,
  });

  String service;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      child: Image.asset("image/$service.png"),
    );
  }
}
