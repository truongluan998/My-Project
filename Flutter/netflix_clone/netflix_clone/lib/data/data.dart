// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter/material.dart';

import '../assets.dart';
import '../models/content_model.dart';
import '../models/support.dart';

Content sintelContent = Content(
  id: DateTime.now(),
  name: 'Sintel',
  imageUrl: Assets.sintel,
  titleImageUrl: Assets.sintelTitle,
  videoUrl: Assets.sintelVideoUrl,
  genre: ['Explosive', 'Exciting', 'Sci-Fi Movie', 'Action & Adventure'],
  description:
      'A lonely young woman, Sintel, helps and befriends a dragon, whom she calls Scales. But when he is kidnapped by an adult dragon, Sintel decides to embark on a dangerous quest to find her lost friend Scales.',
);

List<Support> supportList = [
  Support(
    icon: Icons.login_outlined,
    text: 'Help Center',
    url:
        'https://help.netflix.com/en?fbclid=IwAR1GvoTLxnMCMQeLa6q0mCppl_vCcKPB1klOjArZklwpADghoEhOVzJsT1Y',
  ),
  Support(
    icon: Icons.request_quote_outlined,
    text: 'Request a title',
    url:
        'https://help.netflix.com/en/titlerequest?fbclid=IwAR3kd25NeTl6Dslvq97E1rOoWuHEiI_j0TjUsJtsQ-ylq1C3gWUC2mjoy0Y',
  ),
  Support(
    icon: Icons.lock_outline,
    text: 'Update password',
    url: 'https://www.netflix.com/vn-en/login',
  ),
  Support(
      icon: Icons.cancel_presentation,
      text: 'Cancel account',
      url: 'https://www.netflix.com/vn-en/login',),
  Support(
    icon: Icons.build,
    text: 'Fix a connection problem',
    url:
        'https://help.netflix.com/en/troubleshooting?fbclid=IwAR2U4JmAXHZ39hupsyKXv712gcLh9Ke5PjNKKf2g7se_p_byDr1odTWDc3E',
  ),
  Support(
    icon: Icons.privacy_tip,
    text: 'Privacy',
    url:
        'https://help.netflix.com/legal/privacy?fbclid=IwAR0rfBgBROpiiVvce_U24D_5L63VWrD0HIYHLpcjQct2VoqMTGWy5sDd_TI',
  ),
  Support(
      icon: Icons.document_scanner_outlined,
      text: 'Terms Of User',
      url:
          'https://help.netflix.com/legal/termsofuse?fbclid=IwAR2OjGGTuuIX-RFw-66e_7vJDd0_l5k94jX0GAaUQ1tWxWp2fBvOOP-hZo4',),
];

List<Content> previews = [
  Content(
    id: DateTime.now(),
    name: 'Avatar The Last Airbender',
    imageUrl: Assets.atla,
    color: Colors.orange,
    titleImageUrl: Assets.atlaTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    id: DateTime.now(),
    name: 'The Crown',
    imageUrl: Assets.crown,
    color: Colors.red,
    titleImageUrl: Assets.crownTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    id: DateTime.now(),
    name: 'The Umbrella Academy',
    imageUrl: Assets.umbrellaAcademy,
    color: Colors.yellow,
    titleImageUrl: Assets.umbrellaAcademyTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    id: DateTime.now(),
    name: 'Carole and Tuesday',
    imageUrl: Assets.caroleAndTuesday,
    color: Colors.lightBlueAccent,
    titleImageUrl: Assets.caroleAndTuesdayTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    id: DateTime.now(),
    name: 'Black Mirror',
    imageUrl: Assets.blackMirror,
    color: Colors.green,
    titleImageUrl: Assets.blackMirrorTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    id: DateTime.now(),
    name: 'Avatar The Last Airbender',
    imageUrl: Assets.atla,
    color: Colors.orange,
    titleImageUrl: Assets.atlaTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    id: DateTime.now(),
    name: 'The Crown',
    imageUrl: Assets.crown,
    color: Colors.red,
    titleImageUrl: Assets.crownTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    id: DateTime.now(),
    name: 'The Umbrella Academy',
    imageUrl: Assets.umbrellaAcademy,
    color: Colors.yellow,
    titleImageUrl: Assets.umbrellaAcademyTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    id: DateTime.now(),
    name: 'Carole and Tuesday',
    imageUrl: Assets.caroleAndTuesday,
    color: Colors.lightBlueAccent,
    titleImageUrl: Assets.caroleAndTuesdayTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    id: DateTime.now(),
    name: 'Black Mirror',
    imageUrl: Assets.blackMirror,
    color: Colors.green,
    titleImageUrl: Assets.blackMirrorTitle,
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
];

List<Content> myList = [
  Content(
    name: 'Violet Evergarden',
    imageUrl: Assets.violetEvergarden,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
      name: 'How to Sell Drugs Online (Fast)',
      imageUrl: Assets.htsdof,
      id: DateTime.now(),
      description:
          ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',),
  Content(
    name: 'Kakegurui',
    imageUrl: Assets.kakegurui,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Carole and Tuesday',
    imageUrl: Assets.caroleAndTuesday,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Black Mirror',
    imageUrl: Assets.blackMirror,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Violet Evergarden',
    imageUrl: Assets.violetEvergarden,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'How to Sell Drugs Online (Fast)',
    imageUrl: Assets.htsdof,
    id: DateTime.now(),
  ),
  Content(
    name: 'Kakegurui',
    imageUrl: Assets.kakegurui,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Carole and Tuesday',
    imageUrl: Assets.caroleAndTuesday,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Black Mirror',
    imageUrl: Assets.blackMirror,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
];

List<Content> originals = [
  Content(
    name: 'Stranger Things',
    imageUrl: Assets.strangerThings,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'The Witcher',
    imageUrl: Assets.witcher,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'The Umbrella Academy',
    imageUrl: Assets.umbrellaAcademy,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: '13 Reasons Why',
    imageUrl: Assets.thirteenReasonsWhy,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'The End of the F***ing World',
    imageUrl: Assets.teotfw,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Stranger Things',
    imageUrl: Assets.strangerThings,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'The Witcher',
    imageUrl: Assets.witcher,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'The Umbrella Academy',
    imageUrl: Assets.umbrellaAcademy,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: '13 Reasons Why',
    imageUrl: Assets.thirteenReasonsWhy,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'The End of the F***ing World',
    imageUrl: Assets.teotfw,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
];

List<Content> trending = [
  Content(
    name: 'Explained',
    imageUrl: Assets.explained,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Avatar The Last Airbender',
    imageUrl: Assets.atla,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Tiger King',
    imageUrl: Assets.tigerKing,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'The Crown',
    imageUrl: Assets.crown,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Dogs',
    imageUrl: Assets.dogs,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Explained',
    imageUrl: Assets.explained,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Avatar The Last Airbender',
    imageUrl: Assets.atla,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Tiger King',
    imageUrl: Assets.tigerKing,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'The Crown',
    imageUrl: Assets.crown,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
  Content(
    name: 'Dogs',
    imageUrl: Assets.dogs,
    id: DateTime.now(),
    description:
        ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  ),
];
