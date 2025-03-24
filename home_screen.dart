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
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecommendationsScreen(data: data),
              ),
            );
          },
          child: const Text('Get Recommendations'),
        ),
      ],
    ),
  );
}
