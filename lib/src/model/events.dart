class Event {
  final int _id;
  int activityId;
  int initiatorId;
  DateTime creationTime;
  String eventName;
  String description;
  String location;
  DateTime start;
  DateTime finish;
  String rsvpTime;
  int pictureId;
  int minimumParticipants;
  int maximumParticipants;
  int minimumAge;
  int maximumAge;
  int cost;
  bool verified;

  int get id => _id;

  Event(this._id);

  Event.fromJson(Map<String, dynamic> json)
      : _id = int.parse(json['event_id']),
        activityId = int.parse(json['activity_id']),
        initiatorId = int.parse(json['initiator_id']),
        creationTime = DateTime.parse(json['creation_time']),
        eventName = json['name'],
        description = json['description'],
        location = json['location'],
        start = DateTime.parse(json['start_time']),
        finish = DateTime.parse(json['finish_time']),
        rsvpTime = json['rsvp_time'],
        pictureId = int.parse(json['picture_id']),
        minimumParticipants = int.parse(json['minimum_participants_number']),
        maximumParticipants = int.parse(json['maximum_participants_number']),
        minimumAge = int.parse(json['minimum_age']),
        maximumAge = int.parse(json['maximum_age']),
        cost = int.parse(json['price']),
        verified = bool.fromEnvironment(json['verified']);

  Map<String, dynamic> toJson() =>
      {
        'event_id' : _id,
        'activity_id' : activityId,
        'initiator_id' : initiatorId,
        'creation_time' : creationTime,
        'name' : eventName,
        'description': description,
        'location' : location,
        'start_time' : start,
        'finish_time' : finish,
        'rsvp_time': rsvpTime,
        'picture_id' : pictureId,
        'minimum_participants_number' : minimumParticipants,
        'maximum_participants_number' : maximumParticipants,
        'minimum_age': minimumAge,
        'maximum_age': maximumAge,
        'price' : cost,
        'verified': verified
      };


}