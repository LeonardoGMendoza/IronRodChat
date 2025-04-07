import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardEspiritual extends StatelessWidget {
  const DashboardEspiritual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'), // logo do IronRodChat
        ),
        title: Text("IronRodChat"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {}, // Ações de notificação
          ),
          PopupMenuButton<String>(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
              radius: 16,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(value: "perfil", child: Text("Perfil")),
              PopupMenuItem(value: "config", child: Text("Configurações")),
              PopupMenuItem(value: "sair", child: Text("Sair")),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 28, backgroundImage: AssetImage('assets/profile.jpg')),
                  SizedBox(height: 8),
                  Text("Olá, Leonardo", style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            ListTile(leading: Icon(Icons.group), title: Text('Soc. de Socorro')),
            ListTile(leading: Icon(Icons.shield), title: Text('Élderes')),
            ListTile(leading: Icon(Icons.girl), title: Text('Moças')),
            ListTile(leading: Icon(Icons.group_work), title: Text('Missionários')),
            ListTile(leading: Icon(Icons.family_restroom), title: Text('Família')),
            Divider(),
            ListTile(leading: Icon(Icons.menu_book), title: Text('Estudo das Escrituras')),
            ListTile(leading: Icon(Icons.handshake), title: Text('Pedidos de Ajuda')),
            ListTile(leading: Icon(Icons.shield_moon), title: Text('Mensagens Inspiradoras')),
            ListTile(leading: Icon(Icons.waves), title: Text('Paz nas Tempestades')),
            ListTile(leading: Icon(Icons.flag), title: Text('Metas Espirituais')),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 800;

          return Row(
            children: [
              Expanded(
                flex: 3,
                child: ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    _buildPostCard("João da Ala Central", "Hoje estudei Alma 37:6. Coisas pequenas trazem grandes milagres."),
                    _buildPostCard("Maria do Soc Socorro", "Encontrei paz ao orar esta manhã."),
                  ],
                ),
              ),
              if (isWide)
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.grey[100],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🔔 Eventos", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text("Domingo 9h - Reunião Sacramental"),
                        SizedBox(height: 16),
                        Text("📈 Minhas Metas", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        LinearProgressIndicator(value: 0.5),
                        SizedBox(height: 16),
                        Text("👥 Membros Online", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text("Pedro | Ana | Clara"),
                        SizedBox(height: 16),
                        Text("📜 Versículo do Dia", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text("“Sede fortes e corajosos...” Josué 1:9"),
                      ],
                    ),
                  ),
                )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.edit),
        label: Text("Compartilhar"),
      ),
    );
  }

  Widget _buildPostCard(String author, String message) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage('assets/profile.jpg')),
                SizedBox(width: 8),
                Text(author, style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Text("Agora", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 10),
            Text(message),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(onPressed: () {}, icon: Icon(Icons.thumb_up_alt_outlined), label: Text("Curtir")),
                TextButton.icon(onPressed: () {}, icon: Icon(Icons.comment_outlined), label: Text("Comentar")),
                TextButton.icon(onPressed: () {}, icon: Icon(Icons.share_outlined), label: Text("Compartilhar")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
