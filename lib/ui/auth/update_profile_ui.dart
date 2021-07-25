import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:make_destiny/constants/icon_data.dart';
import 'package:make_destiny/ui/components/components.dart';
import 'package:make_destiny/helpers/helpers.dart';
import 'package:make_destiny/controllers/controllers.dart';
import 'package:make_destiny/ui/components/disable_form_input_field_with_icon.dart';
import 'package:make_destiny/ui/favorite_listen_select_ui.dart';

import '../introduce_myself_select_ui.dart';
import '../favorite_things_select_ui.dart';

class UpdateProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String listenLists = "";
  late String introduceLists = "";
  late String thingsLists = "";

  @override
  Widget build(BuildContext context) {
    authController.nameController.text =
        authController.firestoreUser.value!.name;
    authController.emailController.text =
        authController.firestoreUser.value!.email;

    /// 이런 얘기 많이 들어요 셋팅
    List<dynamic> favoriteListenLists;
    authController.firestoreUser.value!.favoriteListen.forEach((item) {
      listenLists += "$item, ";
    });
    authController.favoriteListenController.text = listenLists;

    /// 저는 이런 사람이에요 셋팅
    List<dynamic> introduceMyselfLists;
    authController.firestoreUser.value!.introduceMyself.forEach((item) {
      introduceLists += "$item, ";
    });
    authController.introduceMyselfController.text = introduceLists;

    /// 저의 관심사는요 셋팅
    List<dynamic> favoriteThingsLists;
    authController.firestoreUser.value!.favoriteThings.forEach((item) {
      thingsLists += "$item, ";
    });
    authController.favoriteThingsController.text = thingsLists;

    final controller = Get.put(AuthController());
    return GetBuilder<AuthController>(
      builder: (_) => controller.firestoreUser.value!.uid == null
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(title: Text('auth.updateProfileTitle'.tr)),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          LogoGraphicHeader(),
                          SizedBox(height: 48.0),
                          FormInputFieldWithIcon(
                            controller: authController.nameController,
                            iconPrefix: Icons.person,
                            labelText: 'auth.nameFormField'.tr,
                            validator: Validator().name,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                authController.nameController.text = value!,
                          ),
                          FormVerticalSpace(),
                          FormInputFieldWithIcon(
                            controller: authController.emailController,
                            iconPrefix: Icons.email,
                            labelText: 'auth.emailFormField'.tr,
                            validator: Validator().email,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                authController.emailController.text = value!,
                          ),
                          FormVerticalSpace(),
                          PrimaryButton(
                              labelText: 'auth.updateUser'.tr,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');

                                  /// 나중에 업데이트해줄 때 마지막 3개는 리스트 값으로 넣어줘야 함 (문자열로 업데이트하지 말 것)
                                  // UserModel _updatedUser = UserModel(
                                  //     uid: authController.firestoreUser.value!.uid,
                                  //     name: authController.nameController.text,
                                  //     email: authController.emailController.text,
                                  //     photoUrl:
                                  //         authController.firestoreUser.value!.photoUrl);
                                  // _updateUserConfirm(context, _updatedUser,
                                  //     authController.firestoreUser.value!.email);
                                }
                              }),
                          FormVerticalSpace(),
                          InkWell(
                              onTap: () async {
                                Get.to(FavoriteListenSelectUI(controller
                                        .firestoreUser.value!.favoriteListen))!
                                    .then((val) {
                                  favoriteListenLists = val;

                                  /// 업데이트 화면에서 DB에 저장하고 그 값을 리턴해주는데 리턴값을 받아와 이 곳에 같이 업데이트 해줌
                                  listenLists = "";
                                  favoriteListenLists.forEach((item) {
                                    listenLists += "$item, ";
                                  });
                                  authController.favoriteListenController.text =
                                      listenLists;
                                  Get.snackbar(
                                      "업데이트 완료", "\'이런 소리를 자주 들어요\' 업데이트 완료",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: Duration(seconds: 4),
                                      backgroundColor: Get
                                          .theme.snackBarTheme.backgroundColor,
                                      colorText: Get
                                          .theme.snackBarTheme.actionTextColor);
                                });
                              },
                              child: DisableFormInputFieldWithIcon(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller:
                                    authController.favoriteListenController,
                                iconPrefix: ear,
                                labelText: '이런 소리를 자주 들어요',
                              )),
                          FormVerticalSpace(),
                          InkWell(
                              onTap: () async {
                                Get.to(IntroduceMyselfSelectUI(controller
                                        .firestoreUser.value!.introduceMyself))!
                                    .then((val) {
                                  introduceMyselfLists = val;

                                  /// 업데이트 화면에서 DB에 저장하고 그 값을 리턴해주는데 리턴값을 받아와 이 곳에 같이 업데이트 해줌
                                  introduceLists = "";
                                  introduceMyselfLists.forEach((item) {
                                    introduceLists += "$item, ";
                                  });
                                  authController.introduceMyselfController
                                      .text = introduceLists;
                                  Get.snackbar(
                                      "업데이트 완료", "\'저는 이런 사람이에요\' 업데이트 완료",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: Duration(seconds: 4),
                                      backgroundColor: Get
                                          .theme.snackBarTheme.backgroundColor,
                                      colorText: Get
                                          .theme.snackBarTheme.actionTextColor);
                                });
                              },
                              child: DisableFormInputFieldWithIcon(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller:
                                    authController.introduceMyselfController,
                                iconPrefix: personAlt,
                                labelText: '저는 이런 사람이에요',
                              )),
                          FormVerticalSpace(),
                          InkWell(
                              onTap: () async {
                                Get.to(FavoriteThingsSelectUI(controller
                                        .firestoreUser.value!.favoriteThings))!
                                    .then((val) {
                                  favoriteThingsLists = val;

                                  /// 업데이트 화면에서 DB에 저장하고 그 값을 리턴해주는데 리턴값을 받아와 이 곳에 같이 업데이트 해줌
                                  thingsLists = "";
                                  favoriteThingsLists.forEach((item) {
                                    thingsLists += "$item, ";
                                  });
                                  authController.favoriteThingsController.text =
                                      thingsLists;
                                  Get.snackbar(
                                      "업데이트 완료", "\'저의 관심사는요\' 업데이트 완료",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: Duration(seconds: 4),
                                      backgroundColor: Get
                                          .theme.snackBarTheme.backgroundColor,
                                      colorText: Get
                                          .theme.snackBarTheme.actionTextColor);
                                });
                              },
                              child: DisableFormInputFieldWithIcon(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller:
                                    authController.favoriteThingsController,
                                iconPrefix: squareFavoritesAlt,
                                labelText: '저의 관심사는요',
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // Future<void> _updateUserConfirm(
  //     BuildContext context, UserModel updatedUser, String oldEmail) async {
  //   final AuthController authController = AuthController.to;
  //   final TextEditingController _password = new TextEditingController();
  //   return Get.dialog(
  //     AlertDialog(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(8.0))),
  //       title: Text(
  //         'auth.enterPassword'.tr,
  //       ),
  //       content: FormInputFieldWithIcon(
  //         controller: _password,
  //         iconPrefix: Icons.lock,
  //         labelText: 'auth.passwordFormField'.tr,
  //         validator: (value) {
  //           String pattern = r'^.{6,}$';
  //           RegExp regex = RegExp(pattern);
  //           if (!regex.hasMatch(value!))
  //             return 'validator.password'.tr;
  //           else
  //             return null;
  //         },
  //         obscureText: true,
  //         onChanged: (value) => null,
  //         onSaved: (value) => _password.text = value!,
  //         maxLines: 1,
  //       ),
  //       actions: <Widget>[
  //         new TextButton(
  //           child: new Text('auth.cancel'.tr.toUpperCase()),
  //           onPressed: () {
  //             Get.back();
  //           },
  //         ),
  //         new TextButton(
  //           child: new Text('auth.submit'.tr.toUpperCase()),
  //           onPressed: () async {
  //             Get.back();
  //             await authController.updateUser(
  //                 context, updatedUser, oldEmail, _password.text);
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
}
