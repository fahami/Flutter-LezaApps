class Drinks {
  String name;

  Drinks({required this.name});

  factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
