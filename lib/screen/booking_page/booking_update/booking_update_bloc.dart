import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';

class BookingDetailBloc extends BaseNetwork {
  PublishSubject<ResponseOb> bookingUpdateController = PublishSubject();
  Stream<ResponseOb> bookingUpdateStream() => bookingUpdateController.stream;

  bookingUpdate(id) {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    bookingUpdateController.sink.add(resp);

    postReq(BOOKING_UPDATE_URL + id.toString(),
        onDataCallBack: (ResponseOb resp) {
      bookingUpdateController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      bookingUpdateController.sink.add(resp);
    });
  }

  dispose() {
    bookingUpdateController.close();
  }
}
