class MediaModel {
  int? id;
  String? title;
  String? imageUrl;
  String? fileUrl;
  String? categoryName;
  int? categoryId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  MediaModel(
      {this.id,
      this.title,
      this.imageUrl,
      this.fileUrl,
      this.categoryName,
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

    if (json.containsKey('Category')) {
      final categoryData = json['Category'] as Map<String, dynamic>;
      categoryName = categoryData['name'];
    }
  }

  static List<MediaModel> mediaFilesFromSnap(List mediaSnapshot) {
    // print('data $mediaSnapshot[0]');

    return mediaSnapshot.map((jsonData) {
      // print('data $jsonData');
      return MediaModel.fromJson(jsonData);
    }).toList();
  }
}
