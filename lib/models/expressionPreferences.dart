class ExpressionPreferences {
  final String emotion;
  final String font;
  final String emoji;
  final String color;

  ExpressionPreferences(
      {required this.emotion,
      required this.font,
      required this.emoji,
      required this.color});

  Map<String, dynamic> toJson() => {
        'emotion': emotion,
        'font': font,
        'emoji': emoji,
        'color': color,
      };
}
