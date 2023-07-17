class OrderSpec {
  int? Id;
  String? OrderDate;
  int? ShipFee;
  String? CustomerName;
  String? ShipperName;
  String? Status;
  String? FromBuildingName;
  String? ToBuildingName;

  OrderSpec(
    this.Id,
    this.OrderDate,
    this.ShipFee,
    this.CustomerName,
    this.ShipperName,
    this.Status,
    this.FromBuildingName,
    this.ToBuildingName,
  );

  int? getId() => this.Id;
  String? getOrderDate() => this.OrderDate;
  int? getShipFee() => this.ShipFee;
  String? getCustomerName() => this.CustomerName;
  String? getShipperName() => this.ShipperName;
  String? getStatus() => this.Status;
  String? getFromBuildingNamee() => this.FromBuildingName;
  String? getToBuildingName() => this.ToBuildingName;

  OrderSpec.fromJson(Map json)
      : Id = json['id'],
        OrderDate = json['orderDate'],
        ShipFee = json['shipFee'],
        CustomerName = json['customer']['name'],
        ShipperName = json['shipper']['name'],
        Status = json['status']['displayName'],
        FromBuildingName = json['fromBuilding']['name'],
        ToBuildingName = json['toBuilding']['name'];
}
