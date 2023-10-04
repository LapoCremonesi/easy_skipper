import 'package:easy_skipper/constant.dart';
import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({
    super.key,
    required this.service,
  });

  final String service;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: const BoxDecoration(
        color: blueCobalto,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: iconMap[service],
      ),
    );
  }
}
