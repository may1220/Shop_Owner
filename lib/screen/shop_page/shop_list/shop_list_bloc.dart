import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/booking_page/bookinglist_ob.dart';
import 'package:shop_owner/screen/shop_page/shop_list/shop_list_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ShopListBloc extends BaseNetwork {
  PublishSubject<ResponseOb> shoplistController = PublishSubject();
  Stream<ResponseOb> shoplistStream() => shoplistController.stream;
  int itemCount = 20;
  int count;
  shoplist() {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    shoplistController.sink.add(resp);
    postReq(SHOPLIST_URL, onDataCallBack: (ResponseOb resp) {
      resp.data = ShopListResponseOb.fromJson(resp.data).shops;
      // count = BookingListResponseOb.fromJson(response.data).count;
      shoplistController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      shoplistController.sink.add(resp);
    });
  }

  dispose() {
    shoplistController.close();
  }
}
