import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';

class BookingCreatinglBloc extends BaseNetwork {
  PublishSubject<ResponseOb> bookingCreatingController = PublishSubject();
  Stream<ResponseOb> bookingCreatingStream() =>
      bookingCreatingController.stream;

  bookingCreating(data, url) {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    bookingCreatingController.sink.add(resp);

    postReq(url, params: data, onDataCallBack: (ResponseOb resp) {
      bookingCreatingController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      bookingCreatingController.sink.add(resp);
    });
  }

  dispose() {
    bookingCreatingController.close();
  }
}
