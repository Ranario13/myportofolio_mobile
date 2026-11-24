import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/utils/auth_guard.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _techStack = TextEditingController();
  final _projectUrl = TextEditingController();
  final _imageUrl = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _techStack.dispose();
    _projectUrl.dispose();
    _imageUrl.dispose();
    super.dispose();
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label tidak boleh kosong.';
    }
    return null;
  }

  String? _optionalUrl(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    final uri = Uri.tryParse(text);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return 'Masukkan URL yang valid, misalnya https://contoh.com.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthState>();
    final apiClient = context.read<ApiClient>();
    if (!await ensureLoggedIn(context)) return;
    final token = auth.token;
    if (token == null) return;

    setState(() {
      _submitting = true;
      _error = null;
    });

    final project = Project(
      title: _title.text.trim(),
      description: _description.text.trim(),
      techStack: _techStack.text.trim(),
      projectUrl: _projectUrl.text.trim(),
      projectImageUrl: _imageUrl.text.trim(),
    );

    try {
      await apiClient.createProject(project, token: token);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Project berhasil ditambahkan'),
          content: const Text('Data project sudah tersimpan di backend.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (mounted) Navigator.pop(context, true);
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await auth.logout();
        if (mounted) {
          setState(() => _error = 'Sesi berakhir. Silakan login kembali.');
        }
      } else {
        setState(() => _error = 'Gagal menyimpan project: ${error.message}');
      }
    } catch (_) {
      if (mounted) setState(() => _error = 'Tidak dapat terhubung ke server.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.viewInsetsOf(context).bottom + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _title,
                decoration: _decoration('Title'),
                validator: (value) => _required(value, 'Title'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _description,
                maxLines: 5,
                decoration: _decoration('Description'),
                validator: (value) => _required(value, 'Description'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _techStack,
                decoration: _decoration('Tech Stack'),
                validator: (value) => _required(value, 'Tech Stack'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _projectUrl,
                keyboardType: TextInputType.url,
                decoration: _decoration('Project URL', hint: 'Opsional'),
                validator: _optionalUrl,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrl,
                keyboardType: TextInputType.url,
                decoration: _decoration('Project Image URL', hint: 'Opsional'),
                validator: _optionalUrl,
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
