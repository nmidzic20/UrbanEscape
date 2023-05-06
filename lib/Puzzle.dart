class Puzzle {
  late String title;
  late String poster_image_url;
  late String city;
  late String country;
  late String avg_time;
  late String rating;
  late String price;
  late String description;
  late String start_location;
  late List<Challenge> questions;
  late int challengesTotal;
  static int currentChallenge = 1;

  Puzzle(
      this.title,
      this.poster_image_url,
      this.city,
      this.country,
      this.avg_time,
      this.rating,
      this.price,
      this.description,
      this.start_location,
      this.questions,
      this.challengesTotal);
}

class Challenge {
  late int id;
  late String question;
  late String answer;
  late String hint;
  late String points;
}
