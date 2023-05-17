class RestaurantEntity {
  String id;
  String name;
  String tags;
  String rating;
  String discount;
  String primaryImage;
  String distance;

  RestaurantEntity({
    required this.id,
    required this.name,
    required this.tags,
    required this.rating,
    required this.discount,
    required this.primaryImage,
    required this.distance,
  });

  factory RestaurantEntity.fromJson(Map<String, dynamic> json) {
    return RestaurantEntity(
      id: json['id'],
      name: json['name'],
      tags: json['tags'],
      rating: json['rating'],
      discount: json['discount'],
      primaryImage: json['primary_image'],
      distance: json['distance'],
    );
  }
}