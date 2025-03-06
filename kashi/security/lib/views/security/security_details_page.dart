import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security/utils/custom_colors.dart';
import 'package:security/controllers/security_controller.dart';

class SecurityDetailView extends StatelessWidget {

  SecurityDetailView({super.key});
  final SecurityController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                // Greeting
              Obx(() => Text(
                'Hi, ${controller.securityName.value} 👋',
                style: const TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              )),

                const SizedBox(height: 20),
                const Divider(thickness: 1, height: 24),

                // Gate Controls Card
                _buildGateControlsCard(),

                const SizedBox(height: 20),

                // Quick Actions Card
                _buildQuickActionsCard(),

                const SizedBox(height: 20),

                // Emergency Contacts Card
                _buildEmergencyContactsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }



Widget _buildGateControlsCard() {
  return Card(
    color: CustomColors.accentColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title: Gate Controls
          const Text(
            'Gate Controls',
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(thickness: 1, height: 24),

          // Gate Buttons
          _buildGateButton('Main Gate'),
          const SizedBox(height: 12),
          _buildGateButton('Pedestrian Gate'),

          const SizedBox(height: 20),

          // Auto-close notice
          Row(
            children: [
              const Icon(Icons.lock_clock, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              const Text(
                'Gates auto-close after 15 seconds.',
                style: TextStyle(fontFamily: 'Satoshi',fontSize: 14, color: Colors.grey),
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
      border: Border.all(
        color: Colors.grey.shade300, // Light gray outline
        width: 1,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Gate name
          Text(
            gateName,
            style: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Open button with lock icon
          ElevatedButton.icon(
            onPressed: () {
              // Gate opening logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.iconColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: Icon(Icons.lock_open, color: CustomColors.white), // Open lock icon
            label: Text(
              'Open',
              style: TextStyle(fontFamily: 'Satoshi',color: CustomColors.white),
            ),
          ),
        ],
      ),
    ),
  );
}



Widget _buildQuickActionsCard() {
  final actions = [
    {
      'icon': Icons.security,
      'name': 'Security Alert',
      'desc': 'Trigger silent alarm',
      'color': Colors.blue,
    },
    {
      'icon': Icons.announcement,
      'name': 'Announce',
      'desc': 'Community announcement',
      'color': Colors.orange,
    },
    {
      'icon': Icons.message,
      'name': 'Message',
      'desc': 'Contact residents',
      'color': Colors.blue,
    },
    {
      'icon': Icons.call,
      'name': 'Call',
      'desc': 'Emergency services',
      'color': Colors.green,
    },
  ];

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

          // Adjusted grid to prevent overflow
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1, // Balanced card size
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return _buildActionButton(
                icon: action['icon'] as IconData,
                name: action['name'] as String,
                desc: action['desc'] as String,
                color: action['color'] as Color,
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildActionButton({
  required IconData icon,
  required String name,
  required String desc,
  required Color color,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon at the top
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 12),
          
          // Action name
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Action description
          Text(
            
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}


Widget _buildEmergencyContactsCard() {
  final contacts = [
    {
      'name': 'Society Manager',
      'icon': Icons.person,
      'iconColor': Colors.blue,
      'number': '+91 234 567 890'
    },
    {
      'name': 'Emergency Contact',
      'icon': Icons.emergency,
      'iconColor': Colors.green,
      'number': '+91 987 654 321'
    },
        {
      'name': 'Police Station',
      'icon': Icons.local_police,
      'iconColor': Colors.red,
      'number': '+100'
    },
        {
      'name': 'Fire Department',
      'icon': Icons.local_fire_department,
      'iconColor': Colors.orange,
      'number': '+101'
    },
  ];

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
                    child: Icon(
                      contact['icon'] as IconData,
                      color: contact['iconColor'] as Color,
                    ),
                  ),
                  title: Text(
                    contact['name'] as String,
                    style: const TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    contact['number'] as String,
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