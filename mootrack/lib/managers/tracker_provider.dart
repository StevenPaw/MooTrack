import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mootrack/pages/MoodTrackerPage/tracker_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackerProvider extends ChangeNotifier {
  SharedPreferences? prefs;

  List<TrackerEntry> _trackerEntries = [];

  List<TrackerEntry> get trackerEntries => _trackerEntries;

  List<TrackerEntry> trackerEntriesOnSelectedDay(DateTime selectedDay) {
    return _trackerEntries.where((entry) {
      return entry.date.year == selectedDay.year &&
          entry.date.month == selectedDay.month &&
          entry.date.day == selectedDay.day;
    }).toList();
  }

  void addTrackerEntry(TrackerEntry trackerEntry) {
    _trackerEntries.add(trackerEntry);
    saveTrackerEntriesIntoPrefs();
    notifyListeners();
  }

  void removeTrackerEntry(TrackerEntry trackerEntry) {
    _trackerEntries.remove(trackerEntry);
    saveTrackerEntriesIntoPrefs();
    notifyListeners();
  }

  void updateTrackerEntry(TrackerEntry oldEntry, TrackerEntry newEntry) {
    final index = _trackerEntries.indexOf(oldEntry);
    _trackerEntries[index] = newEntry;
    saveTrackerEntriesIntoPrefs();
    notifyListeners();
  }

  void clearTrackerEntries() {
    _trackerEntries.clear();
    saveTrackerEntriesIntoPrefs();
    notifyListeners();
  }

  void loadTrackerEntriesFromPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
    final List<String> trackerEntriesJson =
        prefs?.getStringList('trackerEntries') ?? [];
    _trackerEntries = trackerEntriesJson.map((entryJson) {
      final Map<String, dynamic> entryMap = jsonDecode(entryJson);
      return TrackerEntry(
        mood: entryMap['mood'],
        date: DateTime.parse(entryMap['date']),
        note: entryMap['note'],
      );
    }).toList();

    _trackerEntries.sort((a, b) => b.date.compareTo(a.date));
  }

  void saveTrackerEntriesIntoPrefs() async {
    if (prefs == null || !_trackerEntries.isNotEmpty) {
      return;
    }
    final List<String> trackerEntriesJson = _trackerEntries.map((entry) {
      final Map<String, dynamic> entryMap = {
        'mood': entry.mood,
        'date': entry.date.toIso8601String(),
        'note': entry.note,
      };
      return jsonEncode(entryMap);
    }).toList();
    prefs?.setStringList('trackerEntries', trackerEntriesJson);
  }
}
