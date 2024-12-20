import 'package:flutter/material.dart';

class ForwardOutput extends StatelessWidget {
  final double? conductivity;
  final double? elongation;
  final double? UTS;

  const ForwardOutput(
      this.conductivity,
      this.elongation,
      this.UTS, {super.key,}
      );

  List<Map<String, dynamic>> get properties => [
    {
      'title': 'Conductivity',
      'value': '${conductivity?.toStringAsFixed(1) ?? "-"} % IACS',
      'icon': Icons.bolt,
      'color': Colors.blue,
    },
    {
      'title': 'Elongation',
      'value': '${elongation?.toStringAsFixed(1) ?? "-"} %',
      'icon': Icons.straighten,
      'color': Colors.green,
    },
    {
      'title': 'UTS',
      'value': '${UTS?.toStringAsFixed(1) ?? "-"} MPa',
      'icon': Icons.speed,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Physical Properties',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 48, 48, 49),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final property = properties[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: property['color'].withOpacity(0.2),
                          radius: 30,
                          child: Icon(
                            property['icon'],
                            color: property['color'],
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              property['value'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('Edit Inputs'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to next screen
                    // Replace with your actual navigation logic
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => NextScreen(),
                    // ));
                    print('Proceeding to next screen');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('Validate & Proceed',
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}