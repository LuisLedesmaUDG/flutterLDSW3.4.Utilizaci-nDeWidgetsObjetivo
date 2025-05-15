import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;

  const MovieDetailScreen({required this.movieId, super.key});

  @override
  Widget build(BuildContext context) {
    final movieRef = FirebaseFirestore.instance.collection('movies').doc(movieId);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Película')),
      body: FutureBuilder<DocumentSnapshot>(
        future: movieRef.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final movie = snapshot.data!.data() as Map<String, dynamic>?;
          if (movie == null) return const Center(child: Text('Película no encontrada'));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (movie['cover'] != null)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5), // Redondeo de los bordes
                      child: Image.network(
                        movie['cover'],
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    width: 250, // Ancho igual que la imagen
                    child: Column(
                      children: [
                        Text(
                          movie['title'] ?? '',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Año: ${movie['year'] ?? ''}',
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Director: ${movie['director'] ?? ''}',
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Género: ${movie['genre'] ?? ''}',
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Sinopsis:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          movie['synopsis'] ?? '',
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
