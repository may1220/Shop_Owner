import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';

class DeleteBloc extends BaseNetwork {
  PublishSubject<ResponseOb> deleteController = PublishSubject();
  Stream<ResponseOb> deleteStream() => deleteController.stream;

  deleteObject(url) {
    print(url);
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    deleteController.sink.add(resp);

    postReq(url, onDataCallBack: (ResponseOb resp) {
      deleteController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      deleteController.sink.add(resp);
    });
  }

  dispose() {
    deleteController.close();
  }
}
