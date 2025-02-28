import 'package:flutter/material.dart';
import 'package:mootrack/managers/date_manager.dart';
import 'package:mootrack/managers/mood_manager.dart';
import 'package:mootrack/pages/MoodTrackerPage/tracker_entry.dart';

class TrackCard extends StatelessWidget {
  final TrackerEntry trackerEntry;

  const TrackCard({super.key, required this.trackerEntry});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: MoodManager.getIcon(trackerEntry.mood),
        title: Text(DateManager.getFormattedDateAndTime(trackerEntry.date)),
        subtitle: Text(trackerEntry.note),
      ),
    );
  }
}
