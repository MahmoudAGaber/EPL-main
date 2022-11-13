class MainResponse{
  String msg;
  dynamic data;

  MainResponse({this.msg, this.data});

  factory MainResponse.json(Map json){
    return MainResponse(
      msg: json['msg'],
      data: json['data']
    );

  }
}