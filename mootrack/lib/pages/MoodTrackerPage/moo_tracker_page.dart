import 'package:flutter/material.dart';
import 'package:mootrack/managers/tracker_provider.dart';
import 'package:mootrack/pages/MoodTrackerPage/AddTrackPage.dart/add_track_page.dart';
import 'package:mootrack/pages/MoodTrackerPage/track_card.dart';
import 'package:mootrack/pages/MoodTrackerPage/tracker_entry.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MooTrackerPage extends StatefulWidget {
  const MooTrackerPage({super.key});

  @override
  State<MooTrackerPage> createState() => _MooTrackerPageState();

  void refresh() {
    _MooTrackerPageState().refresh();
  }
}

class _MooTrackerPageState extends State<MooTrackerPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                  });
                },
                calendarFormat: _calendarFormat,
                availableCalendarFormats: Map.from({
                  CalendarFormat.month: 'Month',
                  CalendarFormat.week: 'Week',
                }),
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                locale: 'de_DE',
                startingDayOfWeek: StartingDayOfWeek.monday,
              ),
              Divider(),
              Consumer<TrackerProvider>(
                builder: (context, trackerProvider, child) {
                  List<TrackerEntry> entries =
                      trackerProvider.trackerEntriesOnSelectedDay(_selectedDay);
                  entries.sort((a, b) => b.date.compareTo(a.date));

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      return TrackCard(
                        trackerEntry: entries[index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTrackPage(trackerPage: widget)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
