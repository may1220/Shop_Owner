import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/booking_page/bookinglist_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';

class BookingListBloc extends BaseNetwork {
  PublishSubject<ResponseOb> bookinglistController = PublishSubject();
  Stream<ResponseOb> bookinglistStream() => bookinglistController.stream;
  int itemCount = 20;
  int count;
  bookinglist() {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    bookinglistController.sink.add(resp);
    postReq(BOOKINGLIST_URL, onDataCallBack: (ResponseOb resp) {
      resp.data = BookingListResponseOb.fromJson(resp.data).bookings; 
      bookinglistController.sink.add(resp);
      // return resp.data;
    }, errorCallBack: (ResponseOb resp) {
      bookinglistController.sink.add(resp);
    });
  }

  onLoadMore() {
    var data;
    // ResponseOb resp = ResponseOb(message: MsgState.loading);
    // bookinglistController.sink.add(resp);
    postReq(BOOKINGLIST_URL, onDataCallBack: (ResponseOb resp) { 
      data = BookingListResponseOb.fromJson(resp.data).bookings; 
      // return resp.data;
    }, errorCallBack: (ResponseOb resp) {
    });
    return data;
  }

  dispose() {
    bookinglistController.close();
  }
}
