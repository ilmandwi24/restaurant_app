class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final double rating;
  final List<Category>? categories;
  final List<CustomerReview>? customerReviews;
  final Menus? menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    this.categories,
    this.customerReviews,
    this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        address: json["address"] ?? "",
        rating: json["rating"]?.toDouble(),
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : <Category>[],
        customerReviews: json["customerReviews"] != null
            ? List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromJson(x)))
            : <CustomerReview>[],
        menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "menus": menus?.toJson(),
        "rating": rating,
        "customerReviews": customerReviews == null
            ? []
            : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}




class Category {
    final String name;

    Category({
        required this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
    );

     Map<String, dynamic> toJson() => {
        "name": name,
    };

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
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );

     Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
    };

}


class Menus {
    final List? foods;
    final List? drinks;

    Menus({
        this.foods,
        this.drinks,
    });

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null ? [] : List<dynamic>.from(json["foods"]!.map((x) => Category.fromJson(x))),
        drinks: json["drinks"] == null ? [] : List<dynamic>.from(json["drinks"]!.map((x) => Category.fromJson(x))),
    );


    Map<String, dynamic> toJson() => {
        "foods": foods == null ? [] : List<dynamic>.from(foods!.map((x) => x.toJson())),
        "drinks": drinks == null ? [] : List<dynamic>.from(drinks!.map((x) => x.toJson())),
    };

   

   
}