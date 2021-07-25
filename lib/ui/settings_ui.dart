import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:make_destiny/ui/auth/auth.dart';
import 'package:get/get.dart';
import 'package:make_destiny/ui/components/segmented_selector.dart';
import 'package:make_destiny/controllers/controllers.dart';
import 'package:make_destiny/ui/components/components.dart';
import 'package:make_destiny/models/models.dart';
import 'package:make_destiny/constants/constants.dart';

import 'my_card_view_ui.dart';

class SettingsUI extends StatelessWidget {
  //final LanguageController languageController = LanguageController.to;
  //final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) =>
      controller.firestoreUser.value!.uid == null ?
      Center(child: CircularProgressIndicator())
      :
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text('설정',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
              )),
          actions: [
            Icon(Icons.favorite, color: Colors.indigo),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(' 30', textAlign: TextAlign.start, style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold
                  )),
                ],
              ),
            ),
          ],
        ),
        body: _buildLayoutSection(context, controller),
      ),
    );
  }

  Widget _buildLayoutSection(BuildContext context, controller) {
    return ListView(
      children: <Widget>[
        InkWell(
          onTap: () => Get.to(() => MyCardViewUI()),
          child: myCard(context, controller),
        ),
        languageListTile(context),
        themeListTile(context),
        ListTile(
            title: Text('settings.updateProfile'.tr),
            trailing: ElevatedButton(
              onPressed: () async {
                Get.to(UpdateProfileUI());
              },
              child: Text(
                'settings.updateProfile'.tr,
              ),
            )),
        ListTile(
          title: Text('settings.signOut'.tr),
          trailing: ElevatedButton(
            onPressed: () {
              AuthController.to.signOut();
            },
            child: Text(
              'settings.signOut'.tr,
            ),
          ),
        )
      ],
    );
  }

  myCard(context, controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(5), color: Colors.transparent),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.people,
                          size: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.firestoreUser.value!.company,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.05),
                          ),
                          SizedBox(height: 5),
                          Text(
                            controller.firestoreUser.value!.whatToDo,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.04),
                          ),
                        ],
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          controller.firestoreUser.value!.greetings,
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06)),
                    )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    Text('더보기 > ', style: TextStyle(color: Colors.grey))
                  ],
                ),
              ),
            ],
          )),
    );
  }

  languageListTile(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        title: Text('settings.language'.tr),
        trailing: DropdownPicker(
          menuOptions: Globals.languageOptions,
          selectedOption: controller.currentLanguage,
          onChanged: (value) async {
            await controller.updateLanguage(value!);
            Get.forceAppUpdate();
          },
        ),
      ),
    );
  }

  themeListTile(BuildContext context) {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system", value: 'settings.system'.tr, icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light", value: 'settings.light'.tr, icon: Icons.brightness_low),
      MenuOptionsModel(
          key: "dark", value: 'settings.dark'.tr, icon: Icons.brightness_3)
    ];
    return GetBuilder<ThemeController>(
      builder: (controller) => ListTile(
        title: Text('settings.theme'.tr),
        trailing: SegmentedSelector(
          selectedOption: controller.currentTheme,
          menuOptions: themeOptions,
          onValueChanged: (value) {
            controller.setThemeMode(value);
          },
        ),
      ),
    );
  }
}
