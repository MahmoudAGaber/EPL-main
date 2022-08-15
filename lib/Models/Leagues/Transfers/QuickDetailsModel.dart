class QuickDetailsModel{
  String freeTransfer;
  String freeTransferDate;

  QuickDetailsModel({this.freeTransfer, this.freeTransferDate});

  factory QuickDetailsModel.json(Map json){
    return QuickDetailsModel(
      freeTransfer: json[" "],
      freeTransferDate: json["-"]
    );
  }
}