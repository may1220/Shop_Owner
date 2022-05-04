import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/helpers/shared_pref.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ForgetPasswordBloc extends BaseNetwork {
  PublishSubject<ResponseOb> forgetPWController = PublishSubject();
  Stream<ResponseOb> forgetPWStream() => forgetPWController.stream;

  forgetPW(Map<String, String> map) {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    forgetPWController.sink.add(resp);

    postReq(RESETPW_URL, params: map, onDataCallBack: (ResponseOb resp) {
      // SharedPref.setData(key: SharedPref.token,value:"Bearer "+resp.data['token']);
      forgetPWController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      forgetPWController.sink.add(resp);
    });
  }

  dispose() {
    forgetPWController.close();
  }
}
