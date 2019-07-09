class Activities{
  final int _id;
  String activityName;
  DateTime creationTime;
  int pictureId;

  int get id => _id;

  Activities(this._id);

  Activities.fromJson(Map<String, dynamic> json)
    : _id = json['id'],
      activityName = json['activity_name'],
      creationTime = DateTime.parse(json['creation_time']),
      pictureId = json['picture_id'];

  Map<String, dynamic> toJson() =>
      {
        'activity_name' : activityName,
        'creation_time' : creationTime,
        'picture_id' : pictureId
      };


}