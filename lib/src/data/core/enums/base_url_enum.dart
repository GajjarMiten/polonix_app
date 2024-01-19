enum BaseUrl {
  polonix("https://futures-api.poloniex.com/"),
  polonixWSS("wss://futures-apiws.poloniex.com/");

  final String url;

  const BaseUrl(this.url);
}
