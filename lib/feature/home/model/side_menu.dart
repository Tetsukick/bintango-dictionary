enum SideMenu {
  bintango(title: 'BINTANGOについて', url: 'https://jogjalanjalan.com/bintango-guidance/'),
  developerInfo(title: '開発者情報', url: 'https://linktr.ee/TeppeiKikuchi');

  final String title;
  final String url;

  const SideMenu({required this.title, required this.url});
}