import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sdmecom/core/viewmodel/auth_viewmodel.dart';
import 'package:sdmecom/core/viewmodel/control_viewmodel.dart';
import 'package:sdmecom/core/viewmodel/network_viewmodel.dart';
import 'package:sdmecom/pushnotification.dart';
import 'package:sdmecom/view/auth/login_view.dart';
import 'package:sdmecom/view/widgets/custom_text.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message codewaa: ${message.messageId}");
}



class ControlView extends StatefulWidget {

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
late FirebaseMessaging _messaging;

late int _totalNotifications;

PushNotification? _notificationInfo;

void registerNotification() async {
  await Firebase.initializeApp();
  _messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data},',);

      // Parse the message received
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });

      if (_notificationInfo != null) {
        // For displaying the notification as an overlay
        showSimpleNotification(
          Text(_notificationInfo!.title!),
          subtitle: Text(_notificationInfo!.body!),
          background: Colors.cyan.shade700,
          duration: Duration(seconds: 2),
        );
      }
    });
  } else {
    print('User declined or has not accepted permission');
  }
}

// For handling notification when the app is in terminated state
checkForInitialMessage() async {
  await Firebase.initializeApp();
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    PushNotification notification = PushNotification(
      title: initialMessage.notification?.title,
      body: initialMessage.notification?.body,
      dataTitle: initialMessage.data['title'],
      dataBody: initialMessage.data['body'],
    );

    setState(() {
      _notificationInfo = notification;
      _totalNotifications++;
    });
  }
}

@override
void initState() {
  _totalNotifications = 0;
  registerNotification();
  checkForInitialMessage();

  // For handling notification when the app is in background
  // but not terminated
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      dataTitle: message.data['title'],
      dataBody: message.data['body'],
    );

    setState(() {
      _notificationInfo = notification;
      _totalNotifications++;
    });
  });

  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<AuthViewModel>().user == null
          ? LoginView()
          : Get.find<NetworkViewModel>().connectionStatus.value == 1 ||
                  Get.find<NetworkViewModel>().connectionStatus.value == 2
              ? GetBuilder<ControlViewModel>(
                  init: ControlViewModel(),
                  builder: (controller) => Scaffold(
                    body: controller.currentScreen,
                    bottomNavigationBar: CustomBottomNavigationBar(),
                  ),
                )
              : NoInternetConnection();
    });
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84.h,
      child: GetBuilder<ControlViewModel>(
        builder: (controller) => BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          currentIndex: controller.navigatorIndex,
          onTap: (index) {
            controller.changeCurrentScreen(index);
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/images/icons/explore.png',
                fit: BoxFit.contain,
                height: 20.h,
                width: 20.h,
              ),
              activeIcon: CustomText(
                text: 'Explore',
                fontSize: 14,
                alignment: Alignment.center,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/images/icons/cart.png',
                fit: BoxFit.contain,
                height: 20.h,
                width: 20.h,
              ),
              activeIcon: CustomText(
                text: 'Cart',
                fontSize: 14,
                alignment: Alignment.center,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/images/icons/account.png',
                fit: BoxFit.contain,
                height: 20.h,
                width: 20.h,
              ),
              activeIcon: CustomText(
                text: 'Account',
                fontSize: 14,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 30.h,
            ),
            CustomText(
              text: 'Please check your internet connection..',
              fontSize: 14,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
