import 'package:flutter/material.dart';
import 'package:mootrack/managers/mood_manager.dart';
import 'package:mootrack/managers/tracker_provider.dart';
import 'package:mootrack/pages/MoodTrackerPage/moo_tracker_page.dart';
import 'package:mootrack/pages/MoodTrackerPage/tracker_entry.dart';
import 'package:provider/provider.dart';

class AddTrackPage extends StatefulWidget {
  final MooTrackerPage trackerPage;
  const AddTrackPage({super.key, required this.trackerPage});

  @override
  State<AddTrackPage> createState() => _AddTrackPageState();
}

class _AddTrackPageState extends State<AddTrackPage> {
  int _selectedMood = -1;
  String _note = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wie geht's dir gerade?"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    IconButton(
                      iconSize: 100,
                      icon: MoodManager.getIcon(0),
                      onPressed: () {
                        setState(() {
                          _selectedMood = 0;
                        });
                      },
                      color: _selectedMood == 0 ? Colors.green : null,
                    ),
                    IconButton(
                      iconSize: 100,
                      icon: MoodManager.getIcon(1),
                      onPressed: () {
                        setState(() {
                          _selectedMood = 1;
                        });
                      },
                      color: _selectedMood == 1 ? Colors.green : null,
                    ),
                    IconButton(
                      iconSize: 100,
                      icon: MoodManager.getIcon(2),
                      onPressed: () {
                        setState(() {
                          _selectedMood = 2;
                        });
                      },
                      color: _selectedMood == 2 ? Colors.green : null,
                    ),
                    IconButton(
                      iconSize: 100,
                      icon: MoodManager.getIcon(3),
                      onPressed: () {
                        setState(() {
                          _selectedMood = 3;
                        });
                      },
                      color: _selectedMood == 3 ? Colors.green : null,
                    ),
                    IconButton(
                      iconSize: 100,
                      icon: MoodManager.getIcon(4),
                      onPressed: () {
                        setState(() {
                          _selectedMood = 4;
                        });
                      },
                      color: _selectedMood == 4 ? Colors.green : null,
                    ),
                    IconButton(
                      iconSize: 100,
                      icon: MoodManager.getIcon(5),
                      onPressed: () {
                        setState(() {
                          _selectedMood = 5;
                        });
                      },
                      color: _selectedMood == 5 ? Colors.green : null,
                    ),
                  ],
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Warum fühlst du dich so?',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte gib eine kurze Notiz ein';
                    }
                    return null;
                  },
                  onChanged: (value) => _note = value,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Neuer Eintrag hinzugefügt')),
                      );
                    }
                    Provider.of<TrackerProvider>(context, listen: false)
                        .addTrackerEntry(TrackerEntry(
                            mood: _selectedMood,
                            date: DateTime.now(),
                            note: _note));
                    Navigator.pop(context);
                  },
                  child: const Text('Eintragen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
