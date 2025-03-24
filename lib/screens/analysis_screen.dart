import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/inbody_data.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bodyFatController = TextEditingController();
  final _muscleMassController = TextEditingController();
  final _waterLevelController = TextEditingController();

  @override
  void dispose() {
    _bodyFatController.dispose();
    _muscleMassController.dispose();
    _waterLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _bodyFatController,
                decoration: const InputDecoration(labelText: 'Body Fat (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter body fat percentage';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _muscleMassController,
                decoration: const InputDecoration(labelText: 'Muscle Mass (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter muscle mass';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _waterLevelController,
                decoration: const InputDecoration(labelText: 'Water Level (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter water level';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: const Text('Save Analysis'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      final newData = InBodyData(
        bodyFat: double.parse(_bodyFatController.text),
        muscleMass: double.parse(_muscleMassController.text),
        waterLevel: double.parse(_waterLevelController.text),
        date: DateTime.now(),
      );

      Hive.box<InBodyData>('inbodyData').add(newData);
      Navigator.pop(context);
    }
  }
}
