import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/goal.dart';

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
  final List<Goal> _goals = []; // List of all goals
  final TextEditingController _goalController = TextEditingController();
  String _selectedCategory = 'Daily'; // Default category

  void _addGoal() {
    if (_goalController.text.isNotEmpty) {
      setState(() {
        _goals.add(Goal(
          title: _goalController.text,
          category: _selectedCategory,
        ));
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
            child: Column(
              children: [
                TextField(
                  controller: _goalController,
                  decoration: InputDecoration(labelText: 'Enter your goal'),
                ),
                SizedBox(height: 10),
                Text('Select Category:'),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  items: ['Daily', 'Short-term', 'Long-term']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addGoal,
                  child: Text('Add Goal'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildCategorySection('Daily'),
                _buildCategorySection('Short-term'),
                _buildCategorySection('Long-term'),
                _buildCompletedSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String category) {
    final categoryGoals = _goals.where((goal) => goal.category == category && !goal.completed).toList();

    if (categoryGoals.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...categoryGoals.map((goal) => _buildGoalTile(goal)).toList(),
      ],
    );
  }

  Widget _buildGoalTile(Goal goal) {
    return ListTile(
      title: Text(goal.title),
      trailing: Checkbox(
        value: goal.completed,
        onChanged: (bool? value) {
          setState(() {
            goal.completed = value!;
            if (goal.completed) {
              goal.completedDate = DateTime.now();
            } else {
              goal.completedDate = null;
            }
          });
        },
      ),
    );
  }

  Widget _buildCompletedSection() {
    final completedGoals = _goals.where((goal) => goal.completed).toList();

    if (completedGoals.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Completed',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...completedGoals.map((goal) => ListTile(
          title: Text(goal.title),
          subtitle: Text('Completed on ${DateFormat('dd/MM/yy').format(goal.completedDate!)}'),
        )).toList(),
      ],
    );
  }
}
