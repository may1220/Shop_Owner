/// Summarized information of a character.
class StaffList {
  final int id;
  final String name;
  final String pictureUrl;
  StaffList({
    this.id,
    this.name,
    this.pictureUrl,
  });

  factory StaffList.fromJson(Map<String, dynamic> json) =>
      StaffList(
        id: json['char_id'],
        name: json['name'],
        pictureUrl: json['img'],
      );
}
