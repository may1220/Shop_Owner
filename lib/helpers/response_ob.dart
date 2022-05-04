class ResponseOb{
  dynamic data;
  MsgState message;
  ErrState errState;
  PageLoad pageLoad;
  String error;
  String msgerror;

  ResponseOb({this.data,this.message,this.errState,this.pageLoad,this.msgerror});


}


enum MsgState{
  data,
  loading,
  errors
}

enum ErrState{
  userErr,
  tooMany,
  serverError,
  internetError
}

enum PageLoad{
  first,
  nextPage,
  noMore,
}