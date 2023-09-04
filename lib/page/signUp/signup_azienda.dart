import 'package:easy_skipper/widget/custom_user.dart';
import 'package:flutter/material.dart';

class AziendaSignUp extends StatelessWidget {
  AziendaSignUp({super.key, required this.user});

  CustomUser user;

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
