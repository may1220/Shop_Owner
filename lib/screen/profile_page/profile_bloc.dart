import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_owner/helpers/base_network.dart';
import 'package:shop_owner/helpers/response_ob.dart';
import 'package:shop_owner/helpers/shared_pref.dart';
import 'package:shop_owner/screen/profile_page/profile_ob.dart';
import 'package:shop_owner/utils/app_constants.dart';

class ProfileBloc extends BaseNetwork {
  PublishSubject<ResponseOb> profileController = PublishSubject();
  Stream<ResponseOb> profileStream() => profileController.stream;

  PublishSubject<ResponseOb> profileUpdateController = PublishSubject();
  Stream<ResponseOb> profileUpdateStream() => profileUpdateController.stream;

  getProfile() {
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    profileController.sink.add(resp);
    postReq(PROFILE_URL, onDataCallBack: (ResponseOb resp) {
      SharedPref.setData(
          key: SharedPref.profile, value: json.encode(resp.data));
      resp.data = ProfileResponseOb.fromJson(resp.data).user;
      profileController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      profileController.sink.add(resp);
    });
  }

  postProfile(Map<String, dynamic> map) async {
    FormData fd = FormData.fromMap(map);
    ResponseOb resp = ResponseOb(message: MsgState.loading);
    profileUpdateController.sink.add(resp);
    // FormData fd = FormData.fromMap(map);
    postReq(PROFILEUPDATE_URL, fd: fd, onDataCallBack: (ResponseOb resp) {
      SharedPref.setData(
          key: SharedPref.profile, value: json.encode(resp.data));
      profileUpdateController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      profileUpdateController.sink.add(resp);
    });
  }

  dispose() {
    profileController.close();
    profileUpdateController.close();
  }
}
