class Order {
  int? Id;
  int? Status;
  int? CustomerId;
  int? BuildingId;

  Order(this.Id, this.Status, this.BuildingId, this.CustomerId);

  int? getId() => this.Id;
  int? getStatus() => this.Status;
  int? getCustomerId() => this.CustomerId;
  int? getBuildingId() => this.BuildingId;

  Order.fromJson(Map json)
      : Id = json['id'],
        Status = json['status'],
        BuildingId = json['buildingId'],
        CustomerId = json['customerId'];
}
