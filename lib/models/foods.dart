class Foods {
  String name;

  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
