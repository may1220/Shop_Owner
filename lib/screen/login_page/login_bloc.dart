import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/helpers/shared_pref.dart';
import 'package:shop_owner/utils/app_constants.dart';

class LoginBloc extends BaseNetwork {
  PublishSubject<ResponseOb> loginController = PublishSubject();
  Stream<ResponseOb> loginStream() => loginController.stream;

  login(Map<String, String> map) {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    loginController.sink.add(resp);

    postReq(LOGIN_URL, params: map, onDataCallBack: (ResponseOb resp) { 
      SharedPref.setData(key: SharedPref.token,value:"Bearer "+resp.data['token']);
      loginController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      loginController.sink.add(resp);
    });
  }

  dispose() {
    loginController.close();
  }
}
