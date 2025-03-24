import 'package:flutter/material.dart';
import '../models/inbody_data.dart';
import '../services/analysis_service.dart';

class RecommendationsScreen extends StatelessWidget {
  final InBodyData data;
  final AnalysisService service = AnalysisService();

  RecommendationsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Recommendations'),
      ),
      body: FutureBuilder(
        future: service.getRecommendations(data),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final recommendations = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final rec = recommendations[index];
                return Card(
                  child: ListTile(
                    title: Text(rec['title']),
                    subtitle: Text(rec['description']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
