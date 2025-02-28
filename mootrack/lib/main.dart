import 'package:flutter/material.dart';
import 'package:mootrack/managers/tracker_provider.dart';
import 'package:mootrack/pages/HomePage/home_page.dart';
import 'package:mootrack/pages/MooPlannerPage/moo_planner_page.dart';
import 'package:mootrack/pages/MoodTrackerPage/moo_tracker_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => TrackerProvider()),
          ],
          child: const MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<TrackerProvider>(context, listen: false)
        .loadTrackerEntriesFromPrefs();

    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Zuhause',
          ),
          NavigationDestination(
            icon: Icon(Icons.monitor_heart_rounded),
            label: 'Tracker',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Planner',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        HomePage(),

        /// Notifications page
        MooTrackerPage(),

        /// Messages page
        MooPlannerPage(),
      ][currentPageIndex],
    );
  }
}
