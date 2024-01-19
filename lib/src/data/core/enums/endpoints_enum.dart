const _kApiV1 = "/api/v1";

enum Endpoints {
  login("/login"),
  wssEndpoint("/endpoint"),
  connect("$_kApiV1/bullet-public"),
  unknown("");

  final String url;
  const Endpoints(this.url);
}
