import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ShopUpdateBloc extends BaseNetwork {
  PublishSubject<ResponseOb> shopUpdateController = PublishSubject();
  Stream<ResponseOb> shopUpdateStream() => shopUpdateController.stream;
  int itemCount = 20;
  int count;
  shopUpdate(map) {
    FormData fd = FormData.fromMap(map);
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    shopUpdateController.sink.add(resp);
    postReq(SHOP_UPDATE_URL + map["id"], fd: fd,
        onDataCallBack: (ResponseOb resp) {
      shopUpdateController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      shopUpdateController.sink.add(resp);
    });
  }

  PublishSubject<ResponseOb> newShopController = PublishSubject();
  Stream<ResponseOb> newShopStream() => newShopController.stream;
  newShop(map) {
    FormData fd = FormData.fromMap(map);
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    newShopController.sink.add(resp);
    postReq(NEW_SHOP_URL, fd: fd, onDataCallBack: (ResponseOb resp) {
      newShopController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      newShopController.sink.add(resp);
    });
  }

  dispose() {
    shopUpdateController.close();
    newShopController.close();
  }
}
