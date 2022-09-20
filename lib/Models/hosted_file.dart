class HostedFile {
  final String file;

  HostedFile(this.file);

  String get hostedFile => 'https://eplworld.com' + file;
}
