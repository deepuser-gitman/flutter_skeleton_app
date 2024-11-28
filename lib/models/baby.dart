class Baby {
  final int? id; // Nullable id field
  final String name;
  final String gender;
  final DateTime birthdate;
  final String fatherName;
  final String motherName;
  final double weight;

  Baby({
    this.id,
    required this.name,
    required this.gender,
    required this.birthdate,
    required this.fatherName,
    required this.motherName,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'birthdate': birthdate.toIso8601String(),
      'fatherName': fatherName,
      'motherName': motherName,
      'weight': weight,
    };
  }

  factory Baby.fromMap(int id, Map<String, dynamic> map) {
    return Baby(
      id: id,
      name: map['name'],
      gender: map['gender'],
      birthdate: DateTime.parse(map['birthdate']),
      fatherName: map['fatherName'],
      motherName: map['motherName'],
      weight: map['weight'].toDouble(),
    );
  }
}
