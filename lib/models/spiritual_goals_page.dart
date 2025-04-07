import 'package:flutter/material.dart';
import '../models/spiritual_goal.dart';
import '../services/firebase_service.dart';

class SpiritualGoalsPage extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Metas Espirituais')),
      body: StreamBuilder<List<SpiritualGoal>>(
        stream: _firebaseService.getGoals(), // stream aqui
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar metas.'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma meta encontrada.'));
          }

          final goals = snapshot.data!;
          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(goal.description),
                  subtitle: Text(
                    'Frequência: ${goal.frequency} | Progresso: ${goal.progress}%',
                  ),
                  trailing: Text(
                    '${goal.lastUpdated.day}/${goal.lastUpdated.month}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
