import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/inbody_data.dart';
import 'analysis_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<InBodyData> inbodyBox;

  @override
  void initState() {
    super.initState();
    inbodyBox = Hive.box<InBodyData>('inbodyData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InBody Analyzer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToAnalysis(context),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: inbodyBox.listenable(),
        builder: (context, Box<InBodyData> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No data available'));
          }
          
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final data = box.getAt(index)!;
              return ListTile(
                title: Text('Body Fat: ${data.bodyFat.toStringAsFixed(1)}%'),
                subtitle: Text('Muscle Mass: ${data.muscleMass.toStringAsFixed(1)}kg'),
                trailing: Text(data.date.toString().substring(0, 10)),
                onTap: () => _showDetails(context, data),
              );
            },
          );
        },
      ),
    );
  }

  void _navigateToAnalysis(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AnalysisScreen()),
    );
  }

  void _showDetails(BuildContext context, InBodyData data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Body Composition'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Body Fat: ${data.bodyFat}%'),
            Text('Muscle Mass: ${data.muscleMass}kg'),
            Text('Water Level: ${data.waterLevel}%'),
            Text('Date: ${data.date.toString().substring(0, 10)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
