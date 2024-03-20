class MediaModel {
  int? id;
  String? title;
  String? imageUrl;
  String? fileUrl;
  int? categoryId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  MediaModel(
      {this.id,
      this.title,
      this.imageUrl,
      this.fileUrl,
      this.categoryId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  MediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    fileUrl = json['fileUrl'];
    categoryId = json['categoryId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  static List<MediaModel> mediaFilesFromSnap(List mediaSnapshot) {
    // print('data $mediaSnapshot[0]');

    return mediaSnapshot.map((jsonData) {
      // print('data $jsonData');
      return MediaModel.fromJson(jsonData);
    }).toList();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = {};
  //   data['id'] = id;
  //   data['title'] = title;
  //   data['imageUrl'] = imageUrl;
  //   data['fileUrl'] = fileUrl;
  //   data['categoryId'] = categoryId;
  //   data['userId'] = userId;
  //   data['createdAt'] = createdAt;
  //   data['updatedAt'] = updatedAt;
  //   return data;
  // }
}
