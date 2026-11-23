import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/skill_form.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  void _openProjectForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProjectFormPage(),
      ),
    );
  }

  void _openForm(BuildContext context) {
    if (item.name == 'Tambah Proyek') {
      _openProjectForm(context);
    } else if (item.name == 'Skill') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SkillFormPage()),
      );
    } else if (item.name == 'Experience') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menggunakan warna khusus yang ditentukan oleh setiap item.
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () {
          if (item.name == 'Tambah Proyek' ||
              item.name == 'Skill' ||
              item.name == 'Experience') {
            _openForm(context);
            return;
          }

          // Menampilkan SnackBar dengan pesan interaktif.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
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
