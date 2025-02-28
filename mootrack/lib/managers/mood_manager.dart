import 'package:flutter/material.dart';

class MoodManager {
  static Icon getIcon(int moodID) {
    switch (moodID) {
      case 0:
        return Icon(Icons.sentiment_very_dissatisfied,
            size: 40); // Lowest rating
      case 1:
        return Icon(Icons.sentiment_dissatisfied,
            size: 40); // Moderate-low rating
      case 2:
        return Icon(Icons.sentiment_neutral, size: 40); // Neutral rating
      case 3:
        return Icon(Icons.sentiment_satisfied,
            size: 40); // Moderate-high rating
      case 4:
        return Icon(Icons.sentiment_very_satisfied, size: 40); // Highest rating
      default:
        return Icon(Icons.star_border, size: 40); // Default icon
    }
  }
}
