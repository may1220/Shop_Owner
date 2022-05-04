import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';

class DrawerBloc extends BaseNetwork {
  PublishSubject<ResponseOb> logoutController = PublishSubject();
  Stream<ResponseOb> logoutStream() => logoutController.stream;

  logout() {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    logoutController.sink.add(resp);

    postReq(LOGOUT_URL,onDataCallBack: (ResponseOb resp) { 
      logoutController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      logoutController.sink.add(resp);
    });
  }

  dispose() {
    logoutController.close();
  }
}

