class LocalizationService {
  static const List<String> supportedLanguages = [
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'nl',
    'pl',
    'pt',
    'ru',
    'tr',
    'uk',
    'zh',
  ];

  static String getLanguageName(String code) {
    const map = {
      'ar': 'العربية',
      'de': 'Deutsch',
      'en': 'English',
      'es': 'Español',
      'fr': 'Français',
      'hi': 'हिन्दी',
      'id': 'Bahasa Indonesia',
      'it': 'Italiano',
      'ja': '日本語',
      'ko': '한국어',
      'nl': 'Nederlands',
      'pl': 'Polski',
      'pt': 'Português',
      'ru': 'Русский',
      'tr': 'Türkçe',
      'uk': 'Українська',
      'zh': '中文',
    };
    return map[code] ?? code;
  }
}
