import 'package:flutter/material.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  final Map<String, List<String>> resources = const {
    'Ensino': ['Evangelho diário', 'Aulas dominicais'],
    'Música': ['Hinos SUD', 'Música da Primária'],
    'Evangelho': ['Manual Vem e Segue-Me', 'Doutrina e Convênios'],
    'História da Família': ['Árvore Genealógica', 'Indexação'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📚 Recursos")),
      body: ListView(
        children: resources.entries.map((entry) {
          final category = entry.key;
          final items = entry.value;

          return ExpansionTile(
            title: Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: items.map((item) {
              return ListTile(
                title: Text(item),
                trailing: const Icon(Icons.open_in_new),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Abrindo \"$item\"...")),
                  );
                  // Aqui você pode abrir links ou documentos reais futuramente.
                },
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
