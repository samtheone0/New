class Meme {
  final String url;
  final String name;
  final int width;
  final int height;

  Meme(this.url, this.name, this.width, this.height);

  static fromJson(item) {
    return Meme(
        item['url'],
        item['name'],
        item['width'],
        item['height']
    );
  }
}