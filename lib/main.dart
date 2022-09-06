import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sdmecom/helper/binding.dart';
import 'package:sdmecom/pushnotification.dart';
import 'package:sdmecom/view/control_view.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message codewaa: ${message.messageId}");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// For handling notification when the app is in terminated state

  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print(initialMessage);
    PushNotification notification = PushNotification(
      title: initialMessage.notification?.title,
      body: initialMessage.notification?.body,
      dataTitle: initialMessage.data['title'],
      dataBody: initialMessage.data['body'],
    );
  }





  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: OrientationBuilder(
        builder: (context, orientation) => ScreenUtilInit(
          designSize: orientation == Orientation.portrait
              ? Size(375, 812)
              : Size(812, 375),
          builder: (BuildContext context,child) => GetMaterialApp(
            initialBinding: Binding(),
            theme: ThemeData(
              fontFamily: 'SourceSansPro',
            ),
            home: ControlView(),
            debugShowCheckedModeBanner: false,
            title: 'Carray Cart',
          ),
        ),
      ),
    );
  }
}
