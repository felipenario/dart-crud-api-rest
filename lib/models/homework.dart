
class Homework {
  String id;
  String title;
  String discipline;
  String description;
  //DateTime deliveryDate;

  Homework({
    this.id,
    this.title,
    this.discipline,
    this.description
  });


  factory Homework.fromJson(Map<String, dynamic> json){
    return Homework(
      id: json['_id'],
      title: json['title'],
      discipline: json['discipline'],
      description: json['description']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'discipline': discipline,
      'description': description,
      //'deliveryDate': deliveryDate
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'title': title,
      'discipline': discipline,
      'description': description,
      //'deliveryDate': deliveryDate
    };
  }
}