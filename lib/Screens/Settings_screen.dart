import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final String initialCategory;

  const SettingsScreen({super.key, required this.initialCategory});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _category;
  String _unit = 'Celsius';

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
    print("_category: $_category");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context, _category); // Return the selected category
          },
        ),
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Temperature Unit'),
            trailing: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0)),
              child: DropdownButton<String>(
                value: _unit,
                items: <String>['Celsius', 'Fahrenheit'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _unit = newValue!;
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: const Text('News Category'),
            trailing: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0)),
              child: DropdownButton<String>(
                value: _category,
                items: <String>['general', 'business', 'entertainment', 'sports', 'science', 'politics', 'health'].map((String value) {
                  return DropdownMenuItem<String>(         // added some new categories
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue!;
                    print("Selected category: $_category");
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
