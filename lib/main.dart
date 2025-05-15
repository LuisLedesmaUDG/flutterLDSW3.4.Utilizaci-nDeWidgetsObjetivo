/*
PI. Catálogo de películas
Luis Carlos Ledesma Herrera
Diseño de aplicaciones móviles
Producto integrador
15 mayo 2025
*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/admin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PeliculasApp());
}

class PeliculasApp extends StatelessWidget {
  const PeliculasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Películas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/admin': (context) => const AdminScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          if (user.email == 'admin@admin.com') {
            return const AdminScreen();
          } else {
            return const CatalogScreen();
          }
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}

/*
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

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema Collection',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cinema Collection',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 197, 153, 86),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Botones en la parte superior
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 66, 40, 2),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: const Icon(Icons.home),
                      label: const Text('Ingresar'),
                      onPressed: () {
                        // Navegar a pantalla de login
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 158, 109, 50),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Regístrate'),
                      onPressed: () {
                        // Navegar a pantalla de registro
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Logo
              Image.asset(
                'assets/images/logo.png',
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 20),
              const Text(
                '¡Bienvenido!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 219, 157, 23),
                ),
              ),
              const SizedBox(height: 20),
              // Imagen principal
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/spotlight.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

                            const SizedBox(height: 20),
              const Text(
                'Populares',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 168, 120, 17),
                ),
              ),
              // Fila de 3 imágenes adicionales
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/movie1.png',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/movie2.png',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/movie3.png',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart'; // 👈 Importar Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();       // 👈 Necesario antes de inicializar
  await Firebase.initializeApp();                  // 👈 Inicializar Firebase
  runApp(PokeApp());
}

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: PokemonPage(),
    );
  }
}

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  String name = '';
  String imageUrl = '';
  List<Map<String, dynamic>> stats = [];
  List<String> evolutions = [];

  bool isLoading = false;
  String error = '';

  final _controller = TextEditingController();

  Future<void> fetchPokemon(String pokemonName) async {
    setState(() {
      isLoading = true;
      error = '';
      stats = [];
      evolutions = [];
      imageUrl = '';
      name = '';
    });

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          name = data['name'];
          imageUrl = data['sprites']['front_default'];
          stats = (data['stats'] as List)
              .map((stat) => {
                    'name': stat['stat']['name'],
                    'value': stat['base_stat']
                  })
              .toList();
        });

        final speciesUrl = data['species']['url'];
        await fetchEvolutionChain(speciesUrl);
      } else {
        setState(() {
          error = 'Pokémon no encontrado';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error de conexión: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchEvolutionChain(String speciesUrl) async {
    try {
      final speciesRes = await http.get(Uri.parse(speciesUrl));
      if (speciesRes.statusCode == 200) {
        final speciesData = jsonDecode(speciesRes.body);
        final evoUrl = speciesData['evolution_chain']['url'];

        final evoRes = await http.get(Uri.parse(evoUrl));
        if (evoRes.statusCode == 200) {
          final evoData = jsonDecode(evoRes.body);
          List<String> evoList = [];

          void parseChain(dynamic chain) {
            evoList.add(chain['species']['name']);
            if (chain['evolves_to'] != null && chain['evolves_to'].isNotEmpty) {
              parseChain(chain['evolves_to'][0]);
            }
          }

          parseChain(evoData['chain']);
          setState(() {
            evolutions = evoList;
          });
        }
      }
    } catch (e) {
      print('Error obteniendo evolución: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Busca a tu pokemon!'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (imageUrl.isNotEmpty)
              Column(
                children: [
                  Image.network(imageUrl, height: 150),
                  SizedBox(height: 10),
                ],
              ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nombre del Pokémon',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                final input = _controller.text.trim().toLowerCase();
                if (input.isNotEmpty) fetchPokemon(input);
              },
              icon: Icon(Icons.search),
              label: Text('Buscar Pokémon'),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (error.isNotEmpty)
              Text(error, style: TextStyle(color: Colors.red)),
            if (name.isNotEmpty && stats.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: $name',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('Estadísticas:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...stats.map((stat) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text('${stat['name']}: ${stat['value']}'),
                      )),
                  SizedBox(height: 20),
                  if (evolutions.isNotEmpty) ...[
                    Text('Cadena Evolutiva:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(evolutions.join(' → '),
                        style: TextStyle(fontSize: 16)),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // 👈 Firestore

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PokeApp());
}

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonPage(),
    );
  }
}

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  String name = '';
  String imageUrl = '';
  List<Map<String, dynamic>> stats = [];
  List<String> evolutions = [];

  bool isLoading = false;
  String error = '';

  final _controller = TextEditingController();

  Future<void> fetchPokemon(String pokemonName) async {
    setState(() {
      isLoading = true;
      error = '';
      stats = [];
      evolutions = [];
      imageUrl = '';
      name = '';
    });

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          name = data['name'];
          imageUrl = data['sprites']['front_default'];
          stats = (data['stats'] as List)
              .map((stat) => {
                    'name': stat['stat']['name'],
                    'value': stat['base_stat']
                  })
              .toList();
        });

        final speciesUrl = data['species']['url'];
        await fetchEvolutionChain(speciesUrl);
      } else {
        setState(() {
          error = 'Pokémon no encontrado';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error de conexión: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchEvolutionChain(String speciesUrl) async {
    try {
      final speciesRes = await http.get(Uri.parse(speciesUrl));
      if (speciesRes.statusCode == 200) {
        final speciesData = jsonDecode(speciesRes.body);
        final evoUrl = speciesData['evolution_chain']['url'];

        final evoRes = await http.get(Uri.parse(evoUrl));
        if (evoRes.statusCode == 200) {
          final evoData = jsonDecode(evoRes.body);
          List<String> evoList = [];

          void parseChain(dynamic chain) {
            evoList.add(chain['species']['name']);
            if (chain['evolves_to'] != null &&
                chain['evolves_to'].isNotEmpty) {
              parseChain(chain['evolves_to'][0]);
            }
          }

          parseChain(evoData['chain']);
          setState(() {
            evolutions = evoList;
          });
        }
      }
    } catch (e) {
      print('Error obteniendo evolución: $e');
    }
  }

  Future<void> guardarPokemon(String nombre) async {
    final doc = FirebaseFirestore.instance.collection('favoritos').doc(nombre);
    await doc.set({'nombre': nombre});
  }

  Future<void> eliminarPokemon(String nombre) async {
    await FirebaseFirestore.instance
        .collection('favoritos')
        .doc(nombre)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Busca a tu Pokémon!'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (imageUrl.isNotEmpty)
              Column(
                children: [
                  Image.network(imageUrl, height: 150),
                  SizedBox(height: 10),
                ],
              ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nombre del Pokémon',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                final input = _controller.text.trim().toLowerCase();
                if (input.isNotEmpty) fetchPokemon(input);
              },
              icon: Icon(Icons.search),
              label: Text('Buscar Pokémon'),
            ),
            if (name.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () => guardarPokemon(name),
                icon: Icon(Icons.save),
                label: Text('Guardar en favoritos'),
              ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (error.isNotEmpty)
              Text(error, style: TextStyle(color: Colors.red)),
            if (name.isNotEmpty && stats.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: $name',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('Estadísticas:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...stats.map((stat) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text('${stat['name']}: ${stat['value']}'),
                      )),
                  SizedBox(height: 20),
                  if (evolutions.isNotEmpty) ...[
                    Text('Cadena Evolutiva:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(evolutions.join(' → '),
                        style: TextStyle(fontSize: 16)),
                  ],
                ],
              ),
            Divider(height: 30),
            Text('Favoritos guardados:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('favoritos')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error cargando favoritos');
                }
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final nombre = docs[index]['nombre'];
                    return ListTile(
                      title: Text(nombre),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => eliminarPokemon(nombre),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

*/