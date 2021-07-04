class ShowElement{
  String name;
  String description;
  String timeFull;

  ShowElement({
      required this.name,
      required this.description,
      required this.timeFull
  });

  factory ShowElement.fromJson(Map<String, dynamic> json) {
    return ShowElement(
        name: json['name'],
        description: json['description'],
        timeFull: json['timeFull']
    );
  }

}