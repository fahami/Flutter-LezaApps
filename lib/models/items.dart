class Items {
  String name;

  Items({required this.name});

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
