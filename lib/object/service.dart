import 'package:easy_skipper/constant.dart';
import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({
    super.key,
    required this.service,
    required this.height,
    required this.width,
  });

  final String service;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: arancioneBoa,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: iconMap[service],
      ),
    );
  }
}
