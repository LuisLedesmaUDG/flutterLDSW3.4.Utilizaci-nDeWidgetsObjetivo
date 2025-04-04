import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets Demo',
      theme: ThemeData(
        // 🎨 Tema personalizado con colores teal y naranja
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
          secondary: Colors.orange,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Título centrado'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🧭 Barra superior con título centrado
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),

      // 🧱 Cuerpo de la app con desplazamiento vertical
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 👋 Texto centrado principal
            const Center(
              child: Text(
                'Hello, World!',
                style: TextStyle(fontSize: 24),
              ),
            ),

            const SizedBox(height: 40),

            // 📝 Widget Text
            const Text(
              'Este es un widget Text',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            // ↔️ Widget Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.star, color: Colors.orange),
                SizedBox(width: 10),
                Text('Este es un widget Row'),
              ],
            ),

            const SizedBox(height: 20),

            // ⬇️ Widget Column
            Column(
              children: const [
                Text('Elemento de columna 1'),
                Text('Elemento de columna 2'),
                Text('Elemento de columna 3'),
              ],
            ),

            const SizedBox(height: 20),

            // 🎯 Widget Stack (apila widgets uno encima de otro)
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.teal[100],
                ),
                const Text(
                  'Texto sobre el contenedor',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 📦 Widget Container (contenedor con estilo)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Este texto está dentro de un Container',
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
