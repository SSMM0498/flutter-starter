class AppSetting {
  final String theme;
  final String language;
  final double fontScaleFactor;

  AppSetting({
    required this.theme,
    required this.language,
    required this.fontScaleFactor,
  });

  Map<String, dynamic> toJson() => {
        'theme': theme,
        'language': language,
        'fontScaleFactor': fontScaleFactor,
      };

  factory AppSetting.fromJson(Map<String, dynamic> json) {
    return AppSetting(
      theme: json['theme'],
      language: json['language'],
      fontScaleFactor: json['fontScaleFactor']
    );
  }
}