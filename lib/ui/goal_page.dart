import 'package:flutter/material.dart';
import 'package:ironrodchat/models/spiritual_goal.dart';
import 'package:ironrodchat/services/firebase_service.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final FirebaseService _firebaseService = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final _goalController = TextEditingController();

  void _showAddGoalDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nova Meta Espiritual"),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _goalController,
            decoration: const InputDecoration(labelText: "Descreva sua meta"),
            validator: (value) =>
            value == null || value.isEmpty ? "Campo obrigatório" : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final newGoal = SpiritualGoal(
                  id: '',
                  description: _goalController.text.trim(),
                  frequency: 'Diário',
                  progress: 0,
                  lastUpdated: DateTime.now(),
                );
                await _firebaseService.addGoal(newGoal);
                _goalController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(SpiritualGoal goal) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(goal.description),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: goal.progress / 100,
              minHeight: 6,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
            const SizedBox(height: 4),
            Text("Progresso: ${goal.progress}%"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            int newProgress = (goal.progress + 10).clamp(0, 100);
            _firebaseService.updateGoalProgress(goal.id, newProgress);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🎯 Minhas Metas Espirituais")),
      body: StreamBuilder<List<SpiritualGoal>>(
        stream: _firebaseService.getGoals(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar metas"));
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final goals = snapshot.data!;
          if (goals.isEmpty) {
            return const Center(child: Text("Nenhuma meta adicionada ainda."));
          }

          return ListView(
            children: goals.map((goal) => _buildGoalCard(goal)).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGoalDialog,
        child: const Icon(Icons.add),
        tooltip: 'Adicionar Meta',
      ),
    );
  }
}
