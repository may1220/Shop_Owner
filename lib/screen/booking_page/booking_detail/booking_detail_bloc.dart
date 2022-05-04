import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/booking_page/booking_detail/booking_detail_object.dart';
import 'package:shop_owner/utils/app_constants.dart';

class BookingDetailBloc extends BaseNetwork {
  PublishSubject<ResponseOb> bookingDetailController = PublishSubject();
  Stream<ResponseOb> bookingdetailStream() => bookingDetailController.stream;

  bookingDetail(id) {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    bookingDetailController.sink.add(resp);

    postReq(BOOKING_DETAIL_URL + id.toString(),
        onDataCallBack: (ResponseOb resp) {
      resp.data = BookingDetailResponse.fromJson(resp.data).data;
      bookingDetailController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      bookingDetailController.sink.add(resp);
    });
  }

  dispose() {
    bookingDetailController.close();
  }
}
