class OrderDetail {
  int? Quantity;
  String? CategoryName;
  int? ProductId;
  String? ProductName;
  String? ProductImageUrl;
  int? Price;

  OrderDetail(this.Quantity, this.CategoryName, this.ProductId,
      this.ProductName, this.ProductImageUrl, this.Price);

  int? getQuantity() => this.Quantity;
  String? getCategoryName() => this.CategoryName;
  int? getProductId() => this.ProductId;
  String? getProductName() => this.ProductName;
  String? getProductImageUrl() => this.ProductImageUrl;
  int? getPrice() => this.Price;

  OrderDetail.fromJson(Map json)
      : Quantity = json['quantity'],
        CategoryName = json['product']['category']['displayName'],
        ProductId = json['product']['id'],
        ProductName = json['product']['name'],
        ProductImageUrl = json['product']['imageUrl'],
        Price = json['price'];
}
