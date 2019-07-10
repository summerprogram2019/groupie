class Event {
  final int _id;
  int activityId;
  int initiatorId;
  DateTime creationTime;
  String eventName;
  String location;
  DateTime start;
  DateTime finish;
  int pictureId;
  int minimumParticipants;
  int maximumParticipants;
  int cost;

  int get id => _id;

  Event(this._id);

  Event.fromJson(Map<String, dynamic> json)
      : _id = int.parse(json['event_id']),
        activityId = int.parse(json['activity_id']),
        initiatorId = int.parse(json['initiator_id']),
        creationTime = DateTime.parse(json['creation_time']),
        eventName = json['name'],
        location = json['location'],
        start = DateTime.parse(json['start_time']),
        finish = DateTime.parse(json['finish_time']),
        pictureId = int.parse(json['picture_id']),
        minimumParticipants = int.parse(json['minimum_number_participants']),
        maximumParticipants = int.parse(json['maximum_number_participants']),
        cost = int.parse(json['cost']);

  Map<String, dynamic> toJson() =>
      {
        'event_id' : _id,
        'activity_id' : activityId,
        'initiator_id' : initiatorId,
        'creation_time' : creationTime,
        'name' : eventName,
        'location' : location,
        'start_time' : start,
        'finish_time' : finish,
        'picture_id' : pictureId,
        'minimum_number_participants' : minimumParticipants,
        'maximum_number_participants' : maximumParticipants,
        'cost' : cost,
      };


}