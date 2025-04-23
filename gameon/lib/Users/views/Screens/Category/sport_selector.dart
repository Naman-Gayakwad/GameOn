import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SportSelector extends StatefulWidget {
  final Function(String, String)? onSelectionChanged;

  const SportSelector({Key? key, this.onSelectionChanged}) : super(key: key);

  @override
  _SportSelectorState createState() => _SportSelectorState();
}

class _SportSelectorState extends State<SportSelector> {
  bool isIndoor = true;
  String selectedSport = 'Chess';

  final List<String> indoorSports = [
    'select Sport',
    'Chess',
    'Arm Wrestling',
    'Carrom',
    'Meditation',
    'Table Tennis',
    'Wrestling',
    'Yoga',
  ];

  final List<String> outdoorSports = [
    'Cricket',
    'Archery',
    'Athletics',
    'Badminton',
    'Basketball',
    'Cycling',
    'Football',
    'Hockey',
    'Kabaddi',
    'Shooting',
    'Skating',
    'Swimming',
    'Tennis',
    'Volleyball',
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedIndoor = prefs.getBool('isIndoor');
    String? savedSport = prefs.getString('selectedSport');

    setState(() {
      isIndoor = savedIndoor ?? true;
      List<String> currentSports = isIndoor ? indoorSports : outdoorSports;
      selectedSport = (savedSport != null && currentSports.contains(savedSport))
          ? savedSport
          : currentSports.first;
    });

    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(
          isIndoor ? 'Indoor' : 'Outdoor', selectedSport);
    }
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isIndoor', isIndoor);
    await prefs.setString('selectedSport', selectedSport);
  }

  @override
  Widget build(BuildContext context) {
    List<String> sports = isIndoor ? indoorSports : outdoorSports;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.03,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: BorderRadius.circular(6),
                borderColor: Colors.black,
                selectedColor: Colors.white,
                fillColor: Colors.black,
                isSelected: [isIndoor, !isIndoor],
                onPressed: (int index) {
                  setState(() {
                    isIndoor = index == 0;
                    List<String> currentList =
                        isIndoor ? indoorSports : outdoorSports;
                    selectedSport = currentList.first;
                  });
                  _savePreferences();
                  if (widget.onSelectionChanged != null) {
                    widget.onSelectionChanged!(
                        isIndoor ? 'Indoor' : 'Outdoor', selectedSport);
                  }
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'InDoor',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('OutDoor'),
                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade800,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text("Select Sport"),
                      value:
                          sports.contains(selectedSport) ? selectedSport : null,
                      items: sports.map((sport) {
                        return DropdownMenuItem<String>(
                          value: sport,
                          child: Text(sport),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        if (value != null) {
                          setState(() {
                            selectedSport = value;
                          });

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString('selectedSport', value);

                          if (widget.onSelectionChanged != null) {
                            widget.onSelectionChanged!(
                              isIndoor ? "Indoor" : "Outdoor",
                              value,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
