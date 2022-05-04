import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/screen/google_map/location_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';

class GoogleMapBloc extends BaseNetwork {
  PublishSubject<ResponseOb> googleMapController = PublishSubject();
  Stream<ResponseOb> googleMapStream() => googleMapController.stream;

  saveMapData(data) {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    googleMapController.sink.add(resp);

    postReq(createLocation, params: data, onDataCallBack: (ResponseOb resp) {
      googleMapController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      googleMapController.sink.add(resp);
    });
  }

  PublishSubject<ResponseOb> allMapDataController = PublishSubject();
  Stream<ResponseOb> allMapDataStream() => allMapDataController.stream;
  allMapData() {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    allMapDataController.sink.add(resp);
    getReq(ownerMapGetData, onDataCallBack: (ResponseOb response) {
      print("Response Datakdgjastg");
      print(response.data);
      resp.data = LocationDataResponse.fromJson(response.data).data;
      allMapDataController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      allMapDataController.sink.add(resp);
    });
  }

  dispose() {
    googleMapController.close();
    allMapDataController.close();
  }
}
