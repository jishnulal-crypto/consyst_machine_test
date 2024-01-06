class ImageModel {
  String id;
  String url;
  ImageModel({ required this.id, required  this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json["id"],
      url: json['url'],
    );
  }
  toJson() {
    return {"id": id, "url": url};
  }
}
