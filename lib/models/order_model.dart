class Order {
  int? Id;
  String? Status;
  String? CustomerName;
  int? Total;
  String? StoreBuildingName; // New property
  String? CustomerBuildingName;

  Order(this.Id, this.Status, this.CustomerName, this.Total,
      this.StoreBuildingName, this.CustomerBuildingName);

  int? getId() => this.Id;
  String? getStatus() => this.Status;
  String? getCustomerName() => this.CustomerName;
  int? getTotal() => this.Total;
  String? getStoreBuildingName() =>
      this.StoreBuildingName; // Getter for StoreBuildingName
  String? getCustomerBuildingName() => this.CustomerBuildingName;

  Order.fromJson(Map json)
      : Id = json['id'],
        Status = json['status'],
        CustomerName = json['customerName'],
        Total = json['total'],
        StoreBuildingName = json['storeBuilding']
            ['name'], // Assigning value from the JSON object
        CustomerBuildingName = json['customerBuilding']['name'];
}
