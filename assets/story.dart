class Story {
  late String title;
  late String city;
  late String country;
  late String avg_time;
  late String rating;
  late String price;
  late String description;
  late String start_location;
  late List<Challenge> questions;
  static int currentChallenge = 1;
  late int challengesTotal;
}

class Challenge {
  late int id;
  late String question;
  late String answer;
  late String hint;
  late String points;
}