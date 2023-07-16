class Review {
  int? Rate;
  String? Comment;
  String? CustomerAvatarUrl;
  String? CustomerName;

  Review(this.Rate, this.Comment, this.CustomerAvatarUrl, this.CustomerName);

  int? getRate() => this.Rate;
  String? getComment() => this.Comment;
  String? getCustomerAvatarUrl() => this.CustomerAvatarUrl;
  String? getCustomerName() => this.CustomerName;

  Review.fromJson(Map json)
      : Rate = json['rate'],
        Comment = json['comment'],
        CustomerAvatarUrl = json['customer']
            ['avatarUrl'], // Assigning value from the JSON object
        CustomerName = json['customer']['name'];
}
