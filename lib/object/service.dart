import 'package:easy_skipper/constant.dart';
import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({
    super.key,
    required this.service,
    required this.height,
    required this.width,
    required this.size,
    required this.padding,
  });

  final String service;
  final double height;
  final double size;
  final double padding;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: service == 'trasporto' ? EdgeInsets.all(padding) : null,
      decoration: const BoxDecoration(
        color: arancioneBoa,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: service == 'trasporto'
            ? iconMap[service]
            : Icon(
                iconMap[service],
                size: size,
              ),
      ),
    );
  }
}
