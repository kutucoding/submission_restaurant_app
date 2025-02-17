class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String? address;
  final Menus menus;
  final double rating;
  final List<Category> categories;
  final List<CustomerReview> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        city: json["city"] ?? '',
        address: json["address"], 
        pictureId: json["pictureId"] ?? '',
        categories: (json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : <Category>[]),
        menus: json["menus"] != null
            ? Menus.fromJson(json["menus"])
            : Menus.empty(), 
        rating: (json["rating"]?.toDouble()) ?? 0.0,
        customerReviews: (json["customerReviews"] != null
            ? List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromJson(x)))
            : <CustomerReview>[]),
      );

      Map<String, dynamic> toJson() {
        return<String, dynamic>{
          "id": id,
          "name": name,
          "description": description,
          "city": city,
          "address": address,
          "rating": rating,
          "pictureId": pictureId,
        };
      }

      

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.address,
    required this.menus,
    required this.categories,
    required this.customerReviews,
  });
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"] ?? '',
        review: json["review"] ?? '',
        date: json["date"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}

class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Menus {
  final List<Category> foods;
  final List<Category> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: (json["foods"] != null
            ? List<Category>.from(
                json["foods"].map((x) => Category.fromJson(x)))
            : <Category>[]),
        drinks: (json["drinks"] != null
            ? List<Category>.from(
                json["drinks"].map((x) => Category.fromJson(x)))
            : <Category>[]),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };

  factory Menus.empty() {
    return Menus(
      foods: <Category>[],
      drinks: <Category>[],
    );
  }
}
