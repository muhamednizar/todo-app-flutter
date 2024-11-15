

class TodoDM {
  static const String collectionName = 'todo';
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;

  TodoDM(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isDone});

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date.copyWith(),
        "isDone": isDone,
      };

  TodoDM.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    date = json["date"].toDate();
    isDone = json["isDone"];
  }
}
