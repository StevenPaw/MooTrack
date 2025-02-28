import 'package:flutter/material.dart';
import 'package:mootrack/managers/tracker_entry_manager.dart';
import 'package:mootrack/pages/MoodTrackerPage/AddTrackPage.dart/add_track_page.dart';
import 'package:mootrack/pages/MoodTrackerPage/track_card.dart';
import 'package:mootrack/pages/MoodTrackerPage/tracker_entry.dart';
import 'package:table_calendar/table_calendar.dart';

class MooTrackerPage extends StatefulWidget {
  const MooTrackerPage({super.key});

  @override
  State<MooTrackerPage> createState() => _MooTrackerPageState();
}

class _MooTrackerPageState extends State<MooTrackerPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: Center(
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
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
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
            Text(TrackerEntryManager.trackerEntries.length.toString()),
            ListView.builder(
              shrinkWrap: true,
              itemCount:
                  TrackerEntryManager.trackerEntriesOnSelectedDay(_selectedDay)
                      .length,
              itemBuilder: (context, index) {
                return TrackCard(
                  trackerEntry: TrackerEntryManager.trackerEntriesOnSelectedDay(
                      _selectedDay)[index],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTrackPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
