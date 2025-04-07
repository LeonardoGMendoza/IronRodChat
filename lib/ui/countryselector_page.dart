import 'package:flutter/material.dart';
import 'package:ironrodchat/models/organization.dart';
import 'chat_page.dart';
import 'package:animated_background/animated_background.dart';

class CountrySelectorPage extends StatefulWidget {
  const CountrySelectorPage({super.key});

  @override
  _CountrySelectorPageState createState() => _CountrySelectorPageState();
}

class _CountrySelectorPageState extends State<CountrySelectorPage>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> countries = [
    {
      'name': 'Brasil',
      'flagPath': 'assets/images/flags/br.png',
      'org': Organization.socSocorro
    },
    {
      'name': 'Estados Unidos',
      'flagPath': 'assets/images/flags/us.png',
      'org': Organization.elders
    },
    {
      'name': 'México',
      'flagPath': 'assets/images/flags/mx.png',
      'org': Organization.missionarios
    },
    {
      'name': 'Filipinas',
      'flagPath': 'assets/images/flags/ph.png',
      'org': Organization.mocas
    },
    // Adicione mais países conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌍 Escolha um País"),
        backgroundColor: Colors.deepPurple,
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            baseColor: Colors.deepPurple,
            spawnOpacity: 0.4,
            opacityChangeRate: 0.25,
            minOpacity: 0.1,
            maxOpacity: 0.7,
            spawnMinSpeed: 30.0,
            spawnMaxSpeed: 70.0,
            spawnMinRadius: 5.0,
            spawnMaxRadius: 15.0,
            particleCount: 30,
          ),
        ),
        vsync: this,
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: countries.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final country = countries[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(organization: country['org']),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                color: Colors.white.withOpacity(0.9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      country['flagPath'],
                      width: 48,
                      height: 48,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      country['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
