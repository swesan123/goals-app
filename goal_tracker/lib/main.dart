import 'package:flutter/material.dart';

void main() {
  runApp(GoalTrackerApp());
}

class GoalTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goal Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GoalTrackerHome(),
    );
  }
}

class GoalTrackerHome extends StatefulWidget {
  @override
  _GoalTrackerHomeState createState() => _GoalTrackerHomeState();
}

class _GoalTrackerHomeState extends State<GoalTrackerHome> {
  final List<String> _goals = [];
  final TextEditingController _goalController = TextEditingController();

  void _addGoal() {
    if (_goalController.text.isNotEmpty) {
      setState(() {
        _goals.add(_goalController.text);
      });
      _goalController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Goal Tracker')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _goalController,
              decoration: InputDecoration(labelText: 'Enter your goal'),
            ),
          ),
          ElevatedButton(
            onPressed: _addGoal,
            child: Text('Add Goal'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _goals.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_goals[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
