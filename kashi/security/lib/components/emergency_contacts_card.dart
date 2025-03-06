import 'package:flutter/material.dart';
import 'package:security/utils/custom_colors.dart';

class EmergencyContactsCard extends StatelessWidget {
  final List<Map<String, dynamic>> contacts = const [
    {'name': 'Society Manager', 'icon': Icons.person, 'iconColor': Colors.blue, 'number': '+91 234 567 890'},
    {'name': 'Emergency Contact', 'icon': Icons.emergency, 'iconColor': Colors.green, 'number': '+91 987 654 321'},
    {'name': 'Police Station', 'icon': Icons.local_police, 'iconColor': Colors.red, 'number': '+100'},
    {'name': 'Fire Department', 'icon': Icons.local_fire_department, 'iconColor': Colors.orange, 'number': '+101'},
  ];

  const EmergencyContactsCard({super.key});

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
              'Emergency Contacts',
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(thickness: 1, height: 24),
            Column(
              children: contacts.map((contact) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(contact['icon'], color: contact['iconColor']),
                    ),
                    title: Text(
                      contact['name'],
                      style: const TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      contact['number'],
                      style: const TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: const Icon(Icons.phone, color: Colors.green),
                    onTap: () {
                      // Add logic to call the contact
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
