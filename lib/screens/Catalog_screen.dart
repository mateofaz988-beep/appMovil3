import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "MOVIESTREAM",
          style: GoogleFonts.poppins(
            color: const Color(0xFF00F5D4), 
            fontWeight: FontWeight.w900, 
            letterSpacing: 2, 
            fontSize: 24
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/welcome'),
          )
        ],
      ),
      body: _paginas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFF00F5D4),
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_rounded),
            label: 'Top Vistas',
          ),
        ],
      ),
    );
  }
}

class VistaCatalogo extends StatefulWidget {
  const VistaCatalogo({super.key});

  @override
  State<VistaCatalogo> createState() => _VistaCatalogoState();
}

class _VistaCatalogoState extends State<VistaCatalogo> {
  List<Map<String, String>> populares = [];
  List<Map<String, String>> tendencias = [];
  Map<String, String>? destacado;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    const apiKey = 'b1d1f8e417a2599d5d0b021ccf51d8a3';
    const baseUrl = 'https://api.themoviedb.org/3';
    const imgBase = 'https://image.tmdb.org/t/p/w500';

    try {
      final popRes = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=es-ES'));
      final tendRes = await http.get(Uri.parse('$baseUrl/trending/movie/week?api_key=$apiKey&language=es-ES'));

      if (popRes.statusCode == 200 && tendRes.statusCode == 200) {
        final popData = json.decode(popRes.body)['results'] as List;
        final tendData = json.decode(tendRes.body)['results'] as List;

        setState(() {
          populares = popData.map((m) => {
                "id": m['id']?.toString() ?? '',
                "title": m['title']?.toString() ?? 'Sin título',
                "image": m['poster_path'] != null ? imgBase + m['poster_path'] : '',
                "description": m['overview']?.toString() ?? 'Sin descripción',
                "release_date": m['release_date']?.toString() ?? 'Desconocida',
                "vote_average": m['vote_average']?.toString() ?? '0.0'
              }).toList();

          tendencias = tendData.map((m) => {
                "id": m['id']?.toString() ?? '',
                "title": m['title']?.toString() ?? 'Sin título',
                "image": m['poster_path'] != null ? imgBase + m['poster_path'] : '',
                "description": m['overview']?.toString() ?? 'Sin descripción',
                "release_date": m['release_date']?.toString() ?? 'Desconocida',
                "vote_average": m['vote_average']?.toString() ?? '0.0'
              }).toList();

          if (populares.isNotEmpty) destacado = populares.first;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _abrirReproductor(BuildContext context, String titulo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomPlayerScreen(movieTitle: titulo),
      ),
    );
  }

  void _mostrarDetalles(BuildContext context, Map<String, String> peli) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF141414),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Container(
                  width: 45, height: 4,
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: peli['image']!.isNotEmpty
                      ? Image.network(peli['image']!, height: 320, fit: BoxFit.cover)
                      : Container(height: 320, width: 220, color: Colors.grey[900]),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                peli['title']!,
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star_rounded, color: Color(0xFF00F5D4), size: 24),
                  const SizedBox(width: 6),
                  Text(peli['vote_average']!, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(width: 25),
                  const Icon(Icons.calendar_today_rounded, color: Colors.white54, size: 18),
                  const SizedBox(width: 6),
                  Text(peli['release_date']!.split('-')[0], style: GoogleFonts.poppins(fontSize: 16, color: Colors.white54)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00F5D4),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _abrirReproductor(context, peli['title']!);
                },
                icon: const Icon(Icons.play_arrow_rounded, size: 28),
                label: Text("Reproducir Película", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              Text("Sinopsis", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 12),
              Text(peli['description']!, style: GoogleFonts.poppins(fontSize: 15, height: 1.6, color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerDestacado() {
    if (destacado == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => _mostrarDetalles(context, destacado!),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 420, width: double.infinity,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.8), Colors.transparent, Colors.transparent, const Color(0xFF141414)],
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                stops: const [0.0, 0.2, 0.7, 1.0],
              ),
            ),
            child: destacado!['image']!.isNotEmpty
                ? Image.network(destacado!['image']!, fit: BoxFit.cover)
                : Container(color: Colors.grey[900]),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                destacado!['title']!.toUpperCase(),
                style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5),
                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00F5D4),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    onPressed: () => _abrirReproductor(context, destacado!['title']!),
                    icon: const Icon(Icons.play_arrow_rounded, size: 28),
                    label: Text("Reproducir", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                    ),
                    onPressed: () => _mostrarDetalles(context, destacado!),
                    icon: const Icon(Icons.info_outline_rounded, size: 24),
                    label: Text("Información", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator(color: Color(0xFF00F5D4)));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBannerDestacado(),
          const SizedBox(height: 10),
          _buildFilaCategoria(context, "Mi lista de populares", populares),
          const SizedBox(height: 25),
          _buildFilaCategoria(context, "Tendencias actuales", tendencias),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildFilaCategoria(BuildContext context, String categoria, List<Map<String, String>> lista) {
    if (lista.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(categoria, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lista.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final peli = lista[index];
              return GestureDetector(
                onTap: () => _mostrarDetalles(context, peli),
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 6, offset: const Offset(0, 4))],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: peli['image']!.isNotEmpty
                        ? Image.network(peli['image']!, fit: BoxFit.cover, errorBuilder: (c, e, s) => _imageError())
                        : _imageError(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _imageError() => Container(color: Colors.grey[900], child: const Icon(Icons.broken_image_rounded, color: Colors.white30));
}

class CustomPlayerScreen extends StatefulWidget {
  final String movieTitle;
  const CustomPlayerScreen({super.key, required this.movieTitle});

  @override
  State<CustomPlayerScreen> createState() => _CustomPlayerScreenState();
}

class _CustomPlayerScreenState extends State<CustomPlayerScreen> {
  bool isPlaying = true;
  double progressValue = 35.0;
  double volumeValue = 0.7;
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPlaying ? Icons.movie_rounded : Icons.pause_circle_filled_rounded,
                  size: 100,
                  color: isPlaying ? const Color(0xFF00F5D4) : Colors.white38,
                ),
                const SizedBox(height: 20),
                Text(
                  widget.movieTitle,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  isPlaying ? "Streaming en Alta Definición..." : "Video Pausado",
                  style: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.movieTitle,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.hd_rounded, color: Color(0xFF00F5D4), size: 28),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text("01:14", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                    Expanded(
                      child: Slider(
                        value: progressValue,
                        min: 0.0,
                        max: 100.0,
                        activeColor: const Color(0xFF00F5D4),
                        inactiveColor: Colors.white24,
                        onChanged: (value) {
                          setState(() {
                            progressValue = value;
                          });
                        },
                      ),
                    ),
                    Text("03:45", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                          onPressed: () {
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(Icons.replay_10_rounded, color: Colors.white, size: 28),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.forward_10_rounded, color: Colors.white, size: 28),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isMuted || volumeValue == 0
                                ? Icons.volume_off_rounded
                                : volumeValue < 0.5
                                    ? Icons.volume_down_rounded
                                    : Icons.volume_up_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                          onPressed: () {
                            setState(() {
                              isMuted = !isMuted;
                            });
                          },
                        ),
                        SizedBox(
                          width: 90,
                          child: Slider(
                            value: isMuted ? 0.0 : volumeValue,
                            min: 0.0,
                            max: 1.0,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white24,
                            onChanged: (value) {
                              setState(() {
                                volumeValue = value;
                                if (value > 0) isMuted = false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.fullscreen_rounded, color: Colors.white, size: 28),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}