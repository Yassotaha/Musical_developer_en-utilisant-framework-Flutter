import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChannelList {
  final List<Channel> radios;
  ChannelList({
    required this.radios,
  });

  ChannelList copyWith({
    List<Channel>? radios,
  }) {
    return ChannelList(
      radios: radios ?? this.radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radios': radios.map((x) => x.toMap()).toList(),
    };
  }

  factory ChannelList.fromMap(Map<String, dynamic> map) {
    return ChannelList(
      radios: List<Channel>.from(map['radios']?.map((x) => Channel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelList.fromJson(String source) =>
      ChannelList.fromMap(json.decode(source));

  @override
  String toString() => 'ChannelList(radios: $radios)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChannelList && listEquals(other.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}

class Channel {
  final int id;
  final int channelId;
  final String imageUrl;
  final String name;
  final String uri;
  final String countryCode;
  final String genre;
  Channel({
    required this.id,
    required this.channelId,
    required this.imageUrl,
    required this.name,
    required this.uri,
    required this.countryCode,
    required this.genre,
  });

  Channel copyWith({
    int? id,
    int? channelId,
    String? imageUrl,
    String? name,
    String? uri,
    String? countryCode,
    String? genre,
  }) {
    return Channel(
      id: id ?? this.id,
      channelId: channelId ?? this.channelId,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      uri: uri ?? this.uri,
      countryCode: countryCode ?? this.countryCode,
      genre: genre ?? this.genre,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'channelId': channelId,
      'imageUrl': imageUrl,
      'name': name,
      'uri': uri,
      'countryCode': countryCode,
      'genre': genre,
    };
  }

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id']?.toInt() ?? 0,
      channelId: map['channelId']?.toInt() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      name: map['name'] ?? '',
      uri: map['uri'] ?? '',
      countryCode: map['countryCode'] ?? '',
      genre: map['genre'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Channel.fromJson(String source) =>
      Channel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Channel(id: $id, channelId: $channelId, imageUrl: $imageUrl, name: $name, uri: $uri, countryCode: $countryCode, genre: $genre)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Channel &&
        other.id == id &&
        other.channelId == channelId &&
        other.imageUrl == imageUrl &&
        other.name == name &&
        other.uri == uri &&
        other.countryCode == countryCode &&
        other.genre == genre;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        channelId.hashCode ^
        imageUrl.hashCode ^
        name.hashCode ^
        uri.hashCode ^
        countryCode.hashCode ^
        genre.hashCode;
  }
}
