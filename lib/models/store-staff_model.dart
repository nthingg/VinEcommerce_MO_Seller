class StoreStaff {
  String? Name;
  String? Phone;
  String? Email;
  String? AvatarUrl;
  String? StoreAvatarUrl;
  String? StoreName;

  StoreStaff(this.Name, this.Phone, this.Email, this.AvatarUrl,
      this.StoreAvatarUrl, this.StoreName);

  String? getName() => this.Name;
  String? getPhone() => this.Phone;
  String? getEmail() => this.Email;
  String? getAvatarUrl() => this.AvatarUrl;
  String? getStoreAvatarUrl() => this.StoreAvatarUrl;
  String? getStoreName() => this.StoreName;

  StoreStaff.fromJson(Map json)
      : Name = json['name'],
        Phone = json['phone'],
        Email = json['email'],
        AvatarUrl = json['avatarUrl'],
        StoreName =
            json['store']['name'], // Assigning value from the JSON object
        StoreAvatarUrl = json['store']['imageUrl'];
}
