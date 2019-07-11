class Event {
  int eventId;

  int activityId = 0;
  int initiatorId;

  String eventType;
  String name;
  String location;
  String description;
  String activity_name;

  DateTime startTime;
  DateTime finishTime;
  DateTime rsvpTime;

  int pictureId = 4;

  double price;

  int minimumAge;
  int maximumAge;

  int minimumParticipantsNumber;
  int maximumParticipantsNumber;

  int verified = 1;

  void addMajor(String activity_name, String name, String location, DateTime startTime,
      DateTime finishTime) {
    this.activity_name = activity_name;
    this.name = name;
    this.location = location;
    this.startTime = startTime;
    this.finishTime = finishTime;
  }

  void addMinor(
      double price,
      int minimum_age,
      int maximum_age,
      int minimum_participants_number,
      int maximum_participants_number,
      DateTime rsvp_time,
      String description) {
    this.price = price;
    this.minimumAge = minimum_age;
    this.maximumAge = maximum_age;
    this.minimumParticipantsNumber = minimum_participants_number;
    this.maximumParticipantsNumber = maximum_participants_number;
    this.rsvpTime = rsvp_time;
    this.description = description;
  }

  Map<String, String> getRequestMap(int initiatorId) {
    Map<String, String> map = {
//      "event_id" : eventId.toString();
//      "creation_time" : DateTime.now().toString(),
      "activity_id": activityId.toString(),
      "initiator_id": initiatorId.toString(),
      "name": name,
      "location": location,
      "description": description,
      "start_time": startTime.toString(),
      "finish_time": finishTime.toString(),
      "rsvp_time": rsvpTime.toString(),
      "picture_id": pictureId.toString(),
      "minimum_age": minimumAge.toString(),
      "maximum_age": maximumAge.toString(),
      "minimum_participants_number": minimumParticipantsNumber.toString(),
      "maximum_participants_number": maximumParticipantsNumber.toString(),
      "price": price.toString(),
      "verified": verified.toString(),
    };
    return map;
  }

  String getField(){
    return verified.toString();
  }
}
