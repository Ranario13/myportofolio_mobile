import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/skill_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  void _openProjectForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProjectFormPage(),
      ),
    );
  }

  void _openSkillForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SkillFormPage()),
    );
  }

  void _openExperienceForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Portfolio',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Explore personal projects and experiences!',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () => _openProjectForm(context),
          ),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('Skill'),
            onTap: () => _openSkillForm(context),
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Experience'),
            onTap: () => _openExperienceForm(context),
          ),
        ],
      ),
    );
  }
}
