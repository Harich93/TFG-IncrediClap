import 'dart:convert';

class Track {

  late int idAudio;
  late double volume;
  late String duration;

  Track({
    required this.idAudio,
    required this.volume,
    required this.duration
  });

  factory Track.fromJson(String str) => Track.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Track.fromMap(Map<String, dynamic> json) => Track(
    idAudio: json["idAudio"],
    volume: json["volume"],
    duration: json["duration"],
  );

  Map<String, dynamic> toMap() => {
      "idAudio": idAudio,
      "volume": volume,
      "duration": duration,
  };

  Duration parseDuration() {
      int hours = 0;
      int minutes = 0;
      int micros;
      List<String> parts = duration.split(':');
      if (parts.length > 2) {
        hours = int.parse(parts[parts.length - 3]);
      }
      if (parts.length > 1) {
        minutes = int.parse(parts[parts.length - 2]);
      }
      micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
      return Duration(hours: hours, minutes: minutes, microseconds: micros);
    }

}

class AudioRecord {
    
    AudioRecord({
      this.id = "",
      required this.tracks,
      required this.name,
    });

    String id;
    List<Track> tracks;
    String name;

    factory AudioRecord.fromJson(String str) => AudioRecord.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AudioRecord.fromMap(Map<String, dynamic> json) => AudioRecord(
        id: json["id"],
        tracks: json["tracks"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
      "id": id,
      "tracks": tracks,
      "name": name,
    };

}


