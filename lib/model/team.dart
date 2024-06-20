
class Team {

  static final TableNameTeam = 'teams';

  final int id;
  final String name;
  final int foundingYear;
  final DateTime dateChamp;

  const Team({
    required this.id,
    required this.name,
    required this.foundingYear,
    required this.dateChamp,
  });

  

  

  // Método para convertir de Map a Team
  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['_id'],
      name: map['name'],
      foundingYear: map['foundingYear'],
      dateChamp: DateTime.parse(map['dateChamp']),
    );
  }

  // Convertir un perro en un mapa. Las claves deben corresponder a los nombres de los
  // columnas en la base de datos.
  Map<String, Object?> toMap() {
    return {
      '_id': id,
      'name': name,
      'foundingYear': foundingYear,
      'dateChamp': dateChamp.toIso8601String(),//to string en formato estándar internacional 
    };
  }


  Team copy({
    int? id,
    String? name,
    int? foundingYear,
    DateTime? lastChampDate,
  }) => Team(
     id: id ?? this.id,
     name: name ?? this.name,
     foundingYear: foundingYear ?? this.foundingYear,
     dateChamp: dateChamp ?? this.dateChamp,
  );
}
