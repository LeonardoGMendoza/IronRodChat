// lib/models/organization.dart

enum Organization {
  socSocorro,
  elders,
  mocas,
  missionarios,
  familia,
}

extension OrganizationExtension on Organization {
  /// Nome amigável (para exibir no AppBar, etc.)
  String get displayName {
    switch (this) {
      case Organization.socSocorro:
        return 'Sociedade de Socorro';
      case Organization.elders:
        return 'Élderes';
      case Organization.mocas:
        return 'Moças';
      case Organization.missionarios:
        return 'Missionários';
      case Organization.familia:
        return 'Família';
    }
  }

  /// Nome da coleção Firestore, como: chat_socSocorro
  String get firestoreCollection {
    return 'chat_${name}';
  }

  /// Caminho da imagem de capa
  String get coverImage {
    switch (this) {
      case Organization.socSocorro:
        return 'assets/soc_socorro.jpg';
      case Organization.elders:
        return 'assets/elders.jpg';
      case Organization.mocas:
        return 'assets/mocas.jpg';
      case Organization.missionarios:
        return 'assets/missionarios.jpg';
      case Organization.familia:
        return 'assets/familia.jpg';
    }
  }

  /// Transforma string em enum (útil ao ler do banco)
  static Organization? fromName(String name) {
    return Organization.values.firstWhere(
          (e) => e.name == name,
      orElse: () => Organization.familia,
    );
  }
}
