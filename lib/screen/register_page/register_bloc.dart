import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/helpers/shared_pref.dart';
import 'package:shop_owner/utils/app_constants.dart';

class RegisterBloc extends BaseNetwork {
  PublishSubject<ResponseOb> registerController = PublishSubject();
  Stream<ResponseOb> registerStream() => registerController.stream;

  register(Map<String, String> map) {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    registerController.sink.add(resp);

    postReq(REGISTER_URL, params: map, onDataCallBack: (ResponseOb resp) {
      SharedPref.setData(key: SharedPref.token,value:"Bearer "+resp.data['token']);
      registerController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      registerController.sink.add(resp);
    });
  }

  dispose() {
    registerController.close();
  }
}

