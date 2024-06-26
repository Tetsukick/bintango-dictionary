enum AnalyticsScreen {
  BDsignIn,
  BDsignUp,

  BDhome,
  BDdictionaryDetail,
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
  AnalyticsScreen get screen => AnalyticsScreen.BDsignIn;
}

enum SignUpItem with AnalyticsItem {
  backBtn,
  signUp,
  goSignIn;

  @override
  AnalyticsScreen get screen => AnalyticsScreen.BDsignUp;
}

enum HomeItem with AnalyticsItem {
  search;

  @override
  AnalyticsScreen get screen => AnalyticsScreen.BDhome;
}

enum DictionaryDetailItem with AnalyticsItem {
  search;

  @override
  AnalyticsScreen get screen => AnalyticsScreen.BDdictionaryDetail;
}