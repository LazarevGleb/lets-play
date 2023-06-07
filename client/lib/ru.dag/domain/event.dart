class Event {
  final int id;
  final int stadiumId;
  final String beginAt;
  final bool isFinished;
  final bool isCancelled;
  final int minPlayers;
  final int minAge;
  final int maxAge;
  final int minRank;
  final int maxRank;
  final int currentPlayers;
  final String createdAt;

  Event(
      {required this.id,

      required this.stadiumId,
      required this.beginAt,
      required this.isFinished,
      required this.isCancelled,
      required this.minPlayers,
      required this.minAge,
      required this.maxAge,
      required this.minRank,
      required this.maxRank,
      required this.currentPlayers,
      required this.createdAt});

  factory Event.fromJson(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      stadiumId: map['stadiumId'],
      beginAt: map["beginAt"],
      isFinished: map["isFinished"],
      isCancelled: map["isCancelled"],
      createdAt: map["createdAt"],
      minAge: map["minAge"],
      maxAge: map["maxAge"],
      minRank: map["minRank"],
      maxRank: map["maxRank"],
      minPlayers: map["minPlayers"],
      currentPlayers: map["currentPlayers"],
    );
  }
}
