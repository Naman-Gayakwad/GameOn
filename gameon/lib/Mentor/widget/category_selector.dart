import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final Function(String, String)? onSelectionChanged;
  const CategorySelector({super.key, this.onSelectionChanged});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  bool isIndoor = true;
  String selectedSport = 'Chess';

  final List<String> indoorSports = [
    'Carrom',
    'Chess',
    'Pool',
    'Table Tennis',
    'Yoga',
    'Maditation',
    'Arm wrestling',
  ];

  final List<String> outdoorSports = [
    'Cricket',
    'Football',
    'Athelatics',
    'Swimming',
    'Badminton',
    'Kabaddi',
    'Basketball',
    'Volleyball',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> sports = isIndoor ? indoorSports : outdoorSports;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
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

                  if (widget.onSelectionChanged != null) {
                    widget.onSelectionChanged!(
                        isIndoor ? 'Indoor' : 'Outdoor', selectedSport);
                  }
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('InDoor'),
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
                        color: Colors.grey.withOpacity(0.2),
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
                      value: sports.contains(selectedSport)
                          ? selectedSport
                          : sports.first,
                      items: sports.map((sport) {
                        return DropdownMenuItem<String>(
                          value: sport,
                          child: Text(sport),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedSport = value;
                          });

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
