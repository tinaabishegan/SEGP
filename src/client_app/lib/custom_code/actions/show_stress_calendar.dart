import 'package:flutter/material.dart';

class StressCalendar extends StatelessWidget {
  final List<Map<String, dynamic>> stressLevelData;

  StressCalendar(
      {required this.stressLevelData, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    List<DateTime> daysWithStressData = _getDaysWithStressData();

    DateTime currentDate = DateTime.now();
    //print(currentDate);
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Monthly Journal',
          style: TextStyle(
            fontFamily: 'Inter',
            color: Colors.white, // Replace with your desired color
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.17,
          child: Center(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: daysInMonth,
              itemBuilder: (context, index) {
                DateTime day =
                    DateTime(currentDate.year, currentDate.month, index + 1);

                // Check if the day has stress data
                bool hasStressData = daysWithStressData.contains(day);

                return Container(
                  decoration: BoxDecoration(
                    color: hasStressData
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : Color.fromARGB(48, 0, 0, 0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}', // Replace with your desired number
                      style: TextStyle(
                        color: hasStressData ? Colors.black : Colors.white,
                        fontSize: 9,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<DateTime> _getDaysWithStressData() {
    Set<DateTime> uniqueDates = {};

    for (int i = 0; i < stressLevelData.length; i++) {
      DateTime date = DateTime.parse(stressLevelData[i]['date_tested']);
      uniqueDates.add(DateTime(date.year, date.month, date.day));
    }

    //print(stressLevelData);
    //print(uniqueDates.toList());
    return uniqueDates.toList();
  }
}
