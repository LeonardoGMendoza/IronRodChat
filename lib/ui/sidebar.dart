import 'package:flutter/material.dart';
import '../models/organization.dart';
import 'chat_page.dart';
import 'package:ironrodchat/ui/calendar_page.dart';
import 'goal_page.dart';
import 'resources_page.dart';
import 'profile_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8,
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        children: [
          const Text(
            "Organizações",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.group, "Sociedade de Socorro", Organization.socSocorro, context),
          _buildMenuItem(Icons.favorite, "Élderes", Organization.elders, context),
          _buildMenuItem(Icons.book, "Moças", Organization.mocas, context),
          _buildMenuItem(Icons.person_pin, "Missionários", Organization.missionarios, context),
          _buildMenuItem(Icons.home, "Família", Organization.familia, context),

          const Divider(height: 40),

          const Text(
            "Geral",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),

          ListTile(
            leading: const Icon(Icons.calendar_today, color: Colors.deepPurple),
            title: const Text("Calendário"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => CalendarPage())
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.deepPurple),
            title: const Text("Metas Espirituais"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => GoalPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder_copy, color: Colors.deepPurple),
            title: const Text("Recursos"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ResourcesPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.deepPurple),
            title: const Text("Perfil"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, Organization org, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatPage(organization: org),
          ),
        );
      },
    );
  }
}
