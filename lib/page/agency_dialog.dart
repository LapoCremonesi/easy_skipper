import 'package:flutter/material.dart';

class AgencyDialog extends StatefulWidget {
  const AgencyDialog({super.key});

  @override
  State<AgencyDialog> createState() => _AgencyDialogState();
}

class _AgencyDialogState extends State<AgencyDialog> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      child: Container(
        height: height,
        width: width - 20,
      ),
    );
  }
}
