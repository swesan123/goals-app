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
  final List<Map<String, String>> _goals = []; // List to store goals
  final TextEditingController _goalController = TextEditingController();
  String _selectedCategory = 'Daily'; // Default category

  void _addGoal() {
    if (_goalController.text.isNotEmpty) {
      setState(() {
        _goals.add({
          'title': _goalController.text,
          'category': _selectedCategory,
        });
      });
      _goalController.clear(); // Clear the input field
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String category) {
    final categoryGoals = _goals.where((goal) => goal['category'] == category).toList();
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
        ...categoryGoals.map((goal) => ListTile(title: Text(goal['title']!))),
      ],
    );
  }
}
