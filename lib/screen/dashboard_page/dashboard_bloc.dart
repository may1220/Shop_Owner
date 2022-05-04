import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/dashboard_page/dashboardob.dart';
import 'package:shop_owner/utils/app_constants.dart';

class DashboardBloc extends BaseNetwork {
  PublishSubject<ResponseOb> dashboardController = PublishSubject();
  Stream<ResponseOb> dashboardStream() => dashboardController.stream;

  dashboard() {
    ResponseOb resp = ResponseOb(message: MsgState.loading); 
    dashboardController.sink.add(resp);

    postReq(DASHBOARD_URL, onDataCallBack: (ResponseOb resp) { 
      resp.data = DashboardResponseOb.fromJson(resp.data).data;
      dashboardController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      dashboardController.sink.add(resp);
    });
  }

  dispose() {
    dashboardController.close();
  }
}
