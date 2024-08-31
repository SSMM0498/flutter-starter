class AppSetting {
  final String theme;
  final String language;
  final double fontScaleFactor;
  final double playingSpeed;

  AppSetting({
    required this.theme,
    required this.language,
    required this.fontScaleFactor,
    required this.playingSpeed,
  });

  Map<String, dynamic> toJson() => {
        'theme': theme,
        'language': language,
        'fontScaleFactor': fontScaleFactor,
        'playingSpeed': playingSpeed,
      };

  factory AppSetting.fromJson(Map<String, dynamic> json) {
    return AppSetting(
      theme: json['theme'],
      language: json['language'],
      fontScaleFactor: json['fontScaleFactor'],
      playingSpeed: json['playingSpeed'],
    );
  }
}