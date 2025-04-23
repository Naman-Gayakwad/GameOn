import 'package:flutter/material.dart';
import 'package:gameon_addministration/views/screens/mentor/widget/manage_mentor.dart';

class Mentor extends StatelessWidget {
  static const String routeName = '/Mentor';

  Widget _rowHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            color: Colors.yellow.shade700),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Manage Mentor',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              _rowHeader('Name', 2),
              _rowHeader('Email', 3),
              _rowHeader('Phone', 2),
              _rowHeader('certificate', 2),
              _rowHeader('Action', 1),
              _rowHeader('View More', 1)
            ],
          ),
          ManageMentor(),
        ],
      ),
    );
  }
}
