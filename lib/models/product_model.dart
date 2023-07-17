class Product {
  int? Id;
  String? Name;
  String? Description;
  String? ImageUrl;
  int? OriginalPrice;
  int? DiscountPrice;
  int? CategoryId;
  String? CategoryName;

  Product(
    this.Id,
    this.Name,
    this.Description,
    this.ImageUrl,
    this.OriginalPrice,
    this.DiscountPrice,
    this.CategoryId,
    this.CategoryName,
  );

  int? getId() => this.Id;
  String? getName() => this.Name;
  String? getDescription() => this.Description;
  String? getImageUrl() => this.ImageUrl;
  int? getOriginalPrice() => this.OriginalPrice;
  int? getDiscountPrice() => this.DiscountPrice;
  int? getCategoryId() => this.CategoryId;
  String? getCategoryName() => this.CategoryName;

  Product.fromJson(Map json)
      : Id = json['id'],
        Name = json['name'],
        Description = json['description'],
        ImageUrl = json['imageUrl'],
        OriginalPrice = json['originalPrice'],
        DiscountPrice = json['discountPrice'],
        CategoryId = json['category']['categoryId'],
        CategoryName = json['category']['displayName'];
}
