import 'package:flutter/material.dart';
import 'package:security/utils/custom_colors.dart';

class QuickActionsCard extends StatelessWidget {
  final List<Map<String, dynamic>> actions = const [
    {'icon': Icons.security, 'name': 'Security Alert', 'desc': 'Trigger silent alarm', 'color': Colors.blue},
    {'icon': Icons.announcement, 'name': 'Announce', 'desc': 'Community announcement', 'color': Colors.orange},
    {'icon': Icons.message, 'name': 'Message', 'desc': 'Contact residents', 'color': Colors.blue},
    {'icon': Icons.call, 'name': 'Call', 'desc': 'Emergency services', 'color': Colors.green},
  ];

  QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(thickness: 1, height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                final action = actions[index];
                return _buildActionButton(
                  icon: action['icon'],
                  name: action['name'],
                  desc: action['desc'],
                  color: action['color'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String name, required String desc, required Color color}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(fontFamily: 'Satoshi', fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
