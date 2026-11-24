import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/screens/skill_form.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/utils/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  Future<void> _openProjectForm(BuildContext context) async {
    if (!await ensureLoggedIn(context) || !context.mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProjectFormPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          if (item.name == 'Lihat Proyek') {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProjectListScreen()),
            );
            return;
          }
          if (item.name == 'Tambah Proyek') {
            await _openProjectForm(context);
            return;
          }
          if (item.name == 'Skill') {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SkillFormPage()),
            );
            return;
          }
          if (item.name == 'Experience') {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ExperienceFormPage()),
            );
            return;
          }
          if (item.name == 'Logout') {
            final authState = context.read<AuthState>();
            await authState.logout();
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  authState.isLoggedIn ? 'Logout gagal.' : 'Logout berhasil.',
                ),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
