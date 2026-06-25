import 'package:flutter/material.dart';
 
class TopScreen extends StatelessWidget {
  const TopScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> topList = [
      {
        "title": "Interestelar",
        "description": "Un grupo de científicos y exploradores viaja a través de un agujero de gusano."
      },
      {
        "title": "Origen (Inception)",
        "description": "Un ladrón con la habilidad de infiltrarse en los sueños de las personas."
      },
      {
        "title": "The Batman",
        "description": "Batman explora la corrupción en Gotham City mientras persigue al acertijo."
      },
      {
        "title": "Blade Runner 2049",
        "description": "Un nuevo blade runner descubre un secreto profundamente oculto."
      },
    ];
 
    return ListView.builder(
      itemCount: topList.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final peli = topList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(
                "${index + 1}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
            title: Text(peli['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(peli['description']!, maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Top ${index + 1}: ${peli['title']}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(peli['description']!, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}