import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/skill_form.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/utils/auth_guard.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  Future<void> _openProjectForm(BuildContext context) async {
    if (!await ensureLoggedIn(context) || !context.mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProjectFormPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyHomePage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () => _openProjectForm(context),
          ),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('Skill'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SkillFormPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Experience'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ExperienceFormPage()),
            ),
          ),
          Consumer<AuthState>(
            builder: (context, authState, _) {
              if (!authState.isLoggedIn) {
                return ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text('Login'),
                  onTap: () => ensureLoggedIn(context),
                );
              }
              return ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  await authState.logout();
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logout berhasil.')),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
