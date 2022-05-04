import 'package:dio/dio.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/utils/app_constants.dart';

class EditServiceBloc extends BaseNetwork {
  PublishSubject<ResponseOb> editServiceController = PublishSubject();
  Stream<ResponseOb> editServiceStream() => editServiceController.stream;

  updateService(data) {
    print(data);
    FormData fd = FormData.fromMap(data);
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    editServiceController.sink.add(resp);
    postReq(SERVICE_UPDATE_URL + data["id"], fd: fd,
        onDataCallBack: (ResponseOb resp) {
      editServiceController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      editServiceController.sink.add(resp);
    });
  }

  PublishSubject<ResponseOb> newServiceController = PublishSubject();
  Stream<ResponseOb> newServiceStream() => newServiceController.stream;

  newService(data) {
    FormData fd = FormData.fromMap(data);
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    newServiceController.sink.add(resp);
    postReq(NEW_SERVICE_URL, fd: fd, onDataCallBack: (ResponseOb resp) {
      newServiceController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      newServiceController.sink.add(resp);
    });
  }

  dispose() {
    editServiceController.close();
    newServiceController.close();
  }
}
