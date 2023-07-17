class StoreStaff {
  String? Name;
  String? Phone;
  String? Email;
  String? AvatarUrl;
  int? StoreId;
  String? StoreAvatarUrl;
  String? StoreName;

  StoreStaff(this.Name, this.Phone, this.Email, this.AvatarUrl, this.StoreId,
      this.StoreAvatarUrl, this.StoreName);

  String? getName() => this.Name;
  String? getPhone() => this.Phone;
  String? getEmail() => this.Email;
  String? getAvatarUrl() => this.AvatarUrl;
  int? getStoreId() => this.StoreId;
  String? getStoreAvatarUrl() => this.StoreAvatarUrl;
  String? getStoreName() => this.StoreName;

  StoreStaff.fromJson(Map json)
      : Name = json['name'],
        Phone = json['phone'],
        Email = json['email'],
        AvatarUrl = json['avatarUrl'],
        StoreId = json['store']['id'],
        StoreName = json['store']['name'],
        StoreAvatarUrl = json['store']['imageUrl'];
}
