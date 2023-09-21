import 'package:easy_skipper/object/custom_user.dart';
import 'package:flutter/material.dart';

class AziendaSignUp extends StatelessWidget {
  const AziendaSignUp({
    super.key,
    required this.user,
  });

  final CustomUser user;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
