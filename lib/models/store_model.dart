class Store {
  String? Name;
  String? ImageUrl;
  String? CategoryName;
  double? Commission;
  String? BuildingName;

  Store(this.Name, this.ImageUrl, this.CategoryName, this.Commission,
      this.BuildingName);

  String? getName() => this.Name;
  String? getImageUrl() => this.ImageUrl;
  String? getCategoryName() => this.CategoryName;
  double? getCommission() => this.Commission;
  String? getBuildingName() => this.BuildingName;

  Store.fromJson(Map json)
      : Name = json['name'],
        ImageUrl = json['imageUrl'],
        CategoryName = json['category']['displayName'],
        Commission = json['commissionPercent'],
        BuildingName = json['building']['name'];
}
