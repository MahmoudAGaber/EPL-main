class Header{
  String homePercent;
  String awayPercent;

  Header({this.homePercent, this.awayPercent});

  factory Header.json(Map json){
    return Header(
      homePercent: json['homePercent']??'',
      awayPercent: json['awayPercent']??'',
    );
  }
}