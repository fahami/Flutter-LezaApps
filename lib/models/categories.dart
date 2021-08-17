class Categories {
  String name;

  Categories({required this.name});

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
