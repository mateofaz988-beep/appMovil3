import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Top_screen.dart';


class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _currentIndex = 0;

  final List<Widget> _paginas = [
    const VistaCatalogo(),
    const TopScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MovieStream"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/welcome'),
          )
        ],
      ),
      body: _paginas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Top Vistas',
          ),
        ],
      ),
    );
  }
}

// Datos de simulación local imitando la respuesta de la API de TMDb
class MovieData {
  static const List<Map<String, String>> populares = [
    {
      "title": "Interestelar",
      "image": "https://image.tmdb.org/t/p/w500/gEU2vYvK7JWwAsiZdfgYv376YnJ.jpg",
      "description": "Un grupo de científicos viaja a través de un agujero de gusano para salvar a la humanidad del colapso de la Tierra."
    },
    {
      "title": "Origen (Inception)",
      "image": "https://image.tmdb.org/t/p/w500/edv5CZvYjY989v9vFOgXgQv86gX.jpg",
      "description": "Un ladrón con la habilidad de infiltrarse en los sueños debe implantar una idea en la mente de un CEO."
    },
    {
      "title": "El Caballero de la Noche",
      "image": "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
      "description": "Batman enfrenta al Joker, un criminal que amenaza con sumir en el caos a Gotham City."
    },
    {
      "title": "Joker",
      "image": "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
      "description": "Un comediante fracasado cae en la locura y se convierte en el icónico villano Joker."
    },
    {
      "title": "Avengers: Endgame",
      "image": "https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
      "description": "Los Vengadores se unen en un último esfuerzo para revertir los estragos causados por Thanos."
    },
    {
      "title": "Parásitos",
      "image": "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
      "description": "Una familia pobre se infiltra en la vida de una familia rica con consecuencias devastadoras."
    },
  ];

  static const List<Map<String, String>> tendencias = [
    {
      "title": "The Batman",
      "image": "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r96Al63hq.jpg",
      "description": "Batman explora la corrupción en Gotham City mientras persigue al criminal Riddler."
    },
    {
      "title": "Blade Runner 2049",
      "image": "https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg",
      "description": "Un nuevo blade runner descubre un secreto que podría sumergir a la sociedad en el caos."
    },
    {
      "title": "Dune",
      "image": "https://image.tmdb.org/t/p/w500/d5NXSklpcuveUsS2HcE5dKSdFzR.jpg",
      "description": "Un joven noble es enviado al planeta más peligroso del universo para proteger a su familia y su pueblo."
    },
    {
      "title": "Spider-Man: No Way Home",
      "image": "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
      "description": "Spider-Man pide al Doctor Strange alterar los recuerdos del mundo con consecuencias inesperadas."
    },
    {
      "title": "Top Gun: Maverick",
      "image": "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg",
      "description": "Maverick regresa para entrenar a una nueva generación de pilotos de combate de élite."
    },
    {
      "title": "Avatar: El Camino del Agua",
      "image": "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg",
      "description": "Jake Sully y su familia exploran las regiones oceánicas de Pandora y enfrentan una nueva amenaza."
    },
  ];
}

class VistaCatalogo extends StatelessWidget {
  const VistaCatalogo({super.key});

  void _mostrarDetalles(BuildContext context, Map<String, String> peli) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(peli['title']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Text(peli['description']!, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilaCategoria(context, "Populares", MovieData.populares),
          const SizedBox(height: 20),
          _buildFilaCategoria(context, "Tendencias", MovieData.tendencias),
        ],
      ),
    );
  }

  Widget _buildFilaCategoria(BuildContext context, String categoria, List<Map<String, String>> lista) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Text(categoria, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final peli = lista[index];
              return GestureDetector(
                onTap: () => _mostrarDetalles(context, peli),
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            peli['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[800],
                              child: const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(peli['title']!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
