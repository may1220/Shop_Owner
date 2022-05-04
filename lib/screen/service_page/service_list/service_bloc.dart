import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/service_page/service_list/service_list_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ServiceListBloc extends BaseNetwork {
  PublishSubject<ResponseOb> servicelistController = PublishSubject();
  Stream<ResponseOb> servicelistStream() => servicelistController.stream;
  int itemCount = 20;
  int count;
  servicelist() {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    servicelistController.sink.add(resp);
    postReq(SERVICE_LIST_URL, onDataCallBack: (ResponseOb resp) { 
      resp.data = ServiceListResponseOb.fromJson(resp.data).services; 
      servicelistController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      servicelistController.sink.add(resp);
    });
  }


  dispose() {
    servicelistController.close();
  }
}
