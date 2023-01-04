class PostModel {
  PostModel({
    required this.body,
    required this.title,
    required this.id,
  });
  late final String body;
  late final String title;
  late final String id;

  PostModel.fromJson(Map<String, dynamic> doc, String docId) {
    body = doc['body'];
    title = doc['title'];
    id = docId;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['body'] = body;
    _data['title'] = title;
    return _data;
  }
}
