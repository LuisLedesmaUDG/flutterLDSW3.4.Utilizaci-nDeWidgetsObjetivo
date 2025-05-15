import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _directorController = TextEditingController();
  final _genreController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Verificación de usuario admin
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email != 'admin@admin.com') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Acceso denegado. Solo admin puede entrar.')),
        );
        Navigator.of(context).pushNamedAndRemoveUntil('/catalog', (route) => false);
      });
    }
  }

  Future<void> addMovie() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('movies').add({
        'title': _titleController.text.trim(),
        'year': _yearController.text.trim(),
        'director': _directorController.text.trim(),
        'genre': _genreController.text.trim(),
        'synopsis': _synopsisController.text.trim(),
        'cover': _imageUrlController.text.trim(),
      });

      _titleController.clear();
      _yearController.clear();
      _directorController.clear();
      _genreController.clear();
      _synopsisController.clear();
      _imageUrlController.clear();
    }
  }

  Future<void> deleteMovie(String id) async {
    await FirebaseFirestore.instance.collection('movies').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Películas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.movie_filter),
            tooltip: 'Ir a Catálogo',
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/catalog');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _yearController,
                    decoration: const InputDecoration(labelText: 'Año'),
                    validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _directorController,
                    decoration: const InputDecoration(labelText: 'Director'),
                    validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _genreController,
                    decoration: const InputDecoration(labelText: 'Género'),
                    validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _synopsisController,
                    decoration: const InputDecoration(labelText: 'Sinopsis'),
                    validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(labelText: 'URL de imagen'),
                    validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: addMovie,
                    child: const Text('Agregar Película'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('movies').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();

                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final movie = docs[index].data() as Map<String, dynamic>;
                      final id = docs[index].id;
                      return ListTile(
                        title: Text(movie['title'] ?? ''),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteMovie(id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
