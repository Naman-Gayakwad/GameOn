import 'package:flutter/material.dart';
import 'package:gameon_addministration/views/screens/competitions/local/widgets/managelocalcompetitions.dart';

class Localcompetition extends StatelessWidget {
  static const String routeName = '/Localcompetition';

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
              _rowHeader('Description', 3),
              _rowHeader('Paid', 1),
              _rowHeader('Event date', 1),
              _rowHeader('Application end', 1),
              _rowHeader('Venue', 1),
              _rowHeader('Action', 1)
            ],
          ),
          Managelocalcompetitions(),
        ],
      ),
    );
  }
}