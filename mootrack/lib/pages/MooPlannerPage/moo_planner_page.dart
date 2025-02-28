import 'package:flutter/material.dart';

class MooPlannerPage extends StatelessWidget {
  const MooPlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day Planner!'),
      ),
      body: Center(
        child: Text('Welcome to MooPlanner!'),
      ),
    );
  }
}
