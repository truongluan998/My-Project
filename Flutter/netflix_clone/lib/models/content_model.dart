import 'package:flutter/material.dart';

class Content {
  const Content({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.titleImageUrl,
    this.videoUrl,
    this.description,
    this.color,
    this.genre,
  });

  final DateTime? id;
  final String name;
  final String imageUrl;
  final String? titleImageUrl;
  final String? videoUrl;
  final String? description;
  final Color? color;
  final List<String>? genre;
}
