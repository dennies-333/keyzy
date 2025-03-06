import 'package:flutter/material.dart';
import 'package:security/utils/custom_colors.dart';

class GateControlsCard extends StatelessWidget {
  const GateControlsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gate Controls',
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(thickness: 1, height: 24),
            _buildGateButton('Main Gate'),
            const SizedBox(height: 12),
            _buildGateButton('Pedestrian Gate'),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.lock_clock, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                const Text(
                  'Gates auto-close after 15 seconds.',
                  style: TextStyle(fontFamily: 'Satoshi', fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGateButton(String gateName) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.accentColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              gateName,
              style: const TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Add gate logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.iconColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.lock_open, color: CustomColors.white),
              label: Text('Open', style: TextStyle(fontFamily: 'Satoshi', color: CustomColors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
