enum AnalyticsScreen {
  BTsignIn,
  BTsignUp,

  BThome,
}

extension AnalyticsScreenExt on AnalyticsScreen {
  String get name => toString().split('.').last;
}

mixin AnalyticsItem {
  AnalyticsScreen get screen;
  int get index;
  String get shortName => toString().split('.').last;
  String get name => '${screen.name}_$shortName';
  String get screenId => screen.index.toString().padLeft(2, '0');
  String get id => '$screenId${(index + 1).toString().padLeft(2, '0')}';
}

enum SignInItem with AnalyticsItem {
  backBtn,
  signIn,
  forgotPassword,
  goSignUp;

  @override
  AnalyticsScreen get screen => AnalyticsScreen.BTsignIn;
}

enum SignUpItem with AnalyticsItem {
  backBtn,
  signUp,
  goSignIn;

  @override
  AnalyticsScreen get screen => AnalyticsScreen.BTsignUp;
}

enum HomeItem with AnalyticsItem {
  search,
  copy;

  @override
  AnalyticsScreen get screen => AnalyticsScreen.BThome;
}