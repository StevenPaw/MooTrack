import 'dart:convert';

import 'package:mootrack/pages/MoodTrackerPage/tracker_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackerEntryManager {
  static SharedPreferences prefs =
      SharedPreferences.getInstance() as SharedPreferences;

  static List<TrackerEntry> _trackerEntries = [];

  static List<TrackerEntry> get trackerEntries => _trackerEntries;

  static final TrackerEntryManager _singleton = TrackerEntryManager._internal();

  factory TrackerEntryManager() {
    return _singleton;
  }

  TrackerEntryManager._internal();

  static List<TrackerEntry> trackerEntriesOnSelectedDay(DateTime selectedDay) {
    return _trackerEntries.where((entry) {
      return entry.date.year == selectedDay.year &&
          entry.date.month == selectedDay.month &&
          entry.date.day == selectedDay.day;
    }).toList();
  }

  static void addTrackerEntry(TrackerEntry trackerEntry) {
    _trackerEntries.add(trackerEntry);
    saveTrackerEntriesIntoPrefs();
  }

  static void removeTrackerEntry(TrackerEntry trackerEntry) {
    _trackerEntries.remove(trackerEntry);
    saveTrackerEntriesIntoPrefs();
  }

  static void updateTrackerEntry(TrackerEntry oldEntry, TrackerEntry newEntry) {
    final index = _trackerEntries.indexOf(oldEntry);
    _trackerEntries[index] = newEntry;
    saveTrackerEntriesIntoPrefs();
  }

  static void clearTrackerEntries() {
    _trackerEntries.clear();
    saveTrackerEntriesIntoPrefs();
  }

  static void loadTrackerEntriesFromPrefs() async {
    prefs = await SharedPreferences.getInstance();

    final List<String> trackerEntriesJson =
        prefs.getStringList('trackerEntries') ?? [];
    _trackerEntries = trackerEntriesJson.map((entryJson) {
      final Map<String, dynamic> entryMap = jsonDecode(entryJson);
      return TrackerEntry(
        mood: entryMap['mood'],
        date: DateTime.parse(entryMap['date']),
        note: entryMap['note'],
      );
    }).toList();

    _trackerEntries.sort((a, b) => b.date.compareTo(a.date));
    addTrackerEntry(TrackerEntry(
      mood: 3,
      date: DateTime.now(),
      note: 'Das hier ist ein Platzhalter und ein Beispiel zugleich!',
    ));
  }

  static void saveTrackerEntriesIntoPrefs() async {
    final List<String> trackerEntriesJson = _trackerEntries.map((entry) {
      final Map<String, dynamic> entryMap = {
        'mood': entry.mood,
        'date': entry.date.toIso8601String(),
        'note': entry.note,
      };
      return jsonEncode(entryMap);
    }).toList();
    prefs.setStringList('trackerEntries', trackerEntriesJson);
  }
}
