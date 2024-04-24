class Post {
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });
  int? userId;
  int? id;
  String? title;
  String? body;

  //map to object// for doing deserialization
  Post.fromJson(Map<String, dynamic> map) {
    userId = map['userId'];
    id = map['id'];
    title = map['title'];
    body = map['body'];
  }

  // object to map:// for doing serialization
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
