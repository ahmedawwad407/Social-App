class SocialPostModel {
  String? name;
  String? uId;
  String? profileImage;
  String? postImage;
  String? postText;
  String? dateTime;

  SocialPostModel({
    this.name,
    this.profileImage,
    this.uId,
    this.postText,
    this.dateTime,
    this.postImage,

  });

  SocialPostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    profileImage = json['profileImage'];
    postText = json['postText'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'profileImage': profileImage,
      'postText': postText,
      'postImage': postImage,
      'dateTime': dateTime
    };
  }
}
