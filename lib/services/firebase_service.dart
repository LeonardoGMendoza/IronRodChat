import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/spiritual_goal.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔐 Login
  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return result.user;
    } catch (e) {
      print('Erro no login: $e');
      rethrow;
    }
  }

  // 📝 Registro
  Future<User?> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return result.user;
    } catch (e) {
      print('Erro ao registrar: $e');
      rethrow;
    }
  }

  // 🔁 Reset de senha
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return true;
    } catch (e) {
      print('Erro ao enviar recuperação de senha: $e');
      return false;
    }
  }

  // ✉️ Enviar mensagem para uma organização
  Future<void> sendMessage(String organization, String message) async {
    try {
      await _firestore
          .collection('organizations')
          .doc(organization)
          .collection('messages')
          .add({
        'text': message,
        'timestamp': FieldValue.serverTimestamp(),
        'sender': _auth.currentUser?.email ?? 'Anônimo',
      });
    } catch (e) {
      print('Erro ao enviar mensagem: $e');
      rethrow;
    }
  }

  // 📥 Obter mensagens da organização
  Stream<QuerySnapshot> getMessages(String organization) {
    return _firestore
        .collection('organizations')
        .doc(organization)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // 🙏📈 Metas Espirituais

  // Adicionar uma meta espiritual
  Future<void> addGoal(SpiritualGoal goal) async {
    final uid = _auth.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('spiritual_goals')
        .add(goal.toMap());
  }

  // Obter metas espirituais em tempo real
  Stream<List<SpiritualGoal>> getGoals() {
    final uid = _auth.currentUser!.uid;
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('spiritual_goals')
        .orderBy('lastUpdated', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => SpiritualGoal.fromMap(doc.data(), doc.id))
        .toList());
  }

  // Atualizar progresso de uma meta
  Future<void> updateGoalProgress(String goalId, int progress) async {
    final uid = _auth.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('spiritual_goals')
        .doc(goalId)
        .update({
      'progress': progress,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }
}
