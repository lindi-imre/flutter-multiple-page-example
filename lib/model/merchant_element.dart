class MerchantElement{
  String imgUrl;
  String title;
  String url;

  MerchantElement({
    required this.imgUrl,
    required this.title,
    required this.url
  });

  factory MerchantElement.fromJson(Map<String, dynamic> json) {
    return MerchantElement(
        imgUrl: json['imgUrl'],
        title: json['title'],
        url: json['url']
    );
  }

}