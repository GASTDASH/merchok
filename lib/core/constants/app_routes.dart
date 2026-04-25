abstract class AppRoutes {
  static const String home = '/home',
      orders = '/orders',
      stat = '/stat',
      settings = '/settings',
      festival = '/festival',
      theme = '/theme',
      language = '/language',
      export = '/export',
      paymentMethods = '/payment_methods',
      festivalsHistory = '/festivals_history',
      popularMerch = '/popular_merch',
      about = '/about',
      scan = '/scan',
      stock = '/stock',
      onboarding = '/onboarding';

  static const String homeName = 'home',
      ordersName = 'orders',
      statName = 'stat',
      settingsName = 'settings',
      festivalName = 'festival',
      themeName = 'theme',
      languageName = 'language',
      exportName = 'export',
      paymentMethodsName = 'payment_methods',
      festivalsHistoryName = 'festivals_history',
      popularMerchName = 'popular_merch',
      aboutName = 'about',
      privacyPolicyName = 'privacy_policy',
      termsConditionsName = 'terms_conditions',
      scanName = 'scan',
      stockName = 'stock',
      onboardingName = 'onboarding';

  static String privacyPolicy(String languageCode) =>
      '/about/privacy_policy/$languageCode';
  static String termsAndConditions(String languageCode) =>
      '/about/terms_conditions/$languageCode';
}
