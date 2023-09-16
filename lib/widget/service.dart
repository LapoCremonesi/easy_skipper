import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({
    super.key,
    required this.service,
  });

  final String service;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Image.asset("image/$service.png"),
    );
  }
}
