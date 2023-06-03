class Konum {
  final int id;
  final String name;
  final int age;

  Konum({required this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Hakkındaki bilgileri görmeyi kolaylaştırmak için toString'i uygulayın
  // print deyimini kullanırken her Konum.
  @override
  String toString() {
    return 'Konum{id: $id, name: $name, age: $age}';
  }
}