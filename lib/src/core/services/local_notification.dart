import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/gold_vn_model.dart';
import 'package:gold_silver/src/features/dashboard/domain/models/remote/metal_world_price_model.dart';
import 'package:gold_silver/src/utils/constants.dart';
import 'package:gold_silver/src/utils/enums.dart';
import 'package:workmanager/workmanager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const fetchMetalPriceTask = "fetchMetalPriceTask";
late AndroidNotificationChannel channel;

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == fetchMetalPriceTask) {
      await initializeNotifications();
      await fetchGoldPriceAndNotify();
    }
    return Future.value(true);
  });
}

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  channel = const AndroidNotificationChannel(
    'metal_price_channel',
    'Metal Price Alerts',
    description: 'Channel thông báo giá vàng hằng ngày',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

Future<void> fetchGoldPriceAndNotify() async {
  try {
    final bgDio = BgDioClient().dio;
    final goldVNDio = BgDojiDioClient().dio;
    final response = await Future.wait([
      getCurrentWorldPrice(bgDio, MetalType.gold.symbol),
      getCurrentWorldPrice(bgDio, MetalType.silver.symbol),
      getGoldVnData(goldVNDio),
    ]);

    final num goldPrice = (response[0] as MetalWorldPriceModel?)?.price ?? 0;
    final num silverPrice = (response[1] as MetalWorldPriceModel?)?.price ?? 0;
    final num goldSilverRatio = goldPrice / silverPrice;
    final num goldVN = ((response[2] as GoldVnModel?)
                ?.jewelry
                .prices
                .firstWhere((element) => element.key == AppConstant.gold24k)
                .sell ??
            0) *
        10000;

    showNotification(
      goldPrice: goldPrice,
      silverPrice: silverPrice,
      ratio: goldSilverRatio,
      goldVN: goldVN,
    );
  } catch (e) {
    log('Error fetching gold price: $e');
  }
}

Future<MetalWorldPriceModel?> getCurrentWorldPrice(Dio dio, String symbol) async {
  try {
    final res = await dio.get('/api/$symbol/USD');
    return MetalWorldPriceModel.fromJson(res.data);
  } catch (e) {
    return null;
  }
}

Future<GoldVnModel?> getGoldVnData(Dio dio) async {
  try {
    final res = await dio.get('/v1/gold-prices');
    return GoldVnModel.fromJson(res.data);
  } catch (e) {
    return null;
  }
}

Future<void> showNotification({
  num goldPrice = 0,
  num silverPrice = 0,
  num ratio = 0,
  num goldVN = 0,
}) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channel.id, channel.name, channelDescription: channel.description,
    importance: Importance.max,
    priority: Priority.high,
    // ticker: 'ticker',
  );
  NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  String text1 = goldPrice > 0
      ? 'Giá vàng: ${goldPrice.toStringAsFixed(2)} USD/oz, Giá bạc: ${silverPrice.toStringAsFixed(2)} USD/oz, Tỷ lệ vàng/bạc: ${ratio.toStringAsFixed(2)}\n'
      : '';
  String text2 = goldVN > 0 ? 'Giá vàng VN: ${goldVN.toStringAsFixed(0)}VND/lượng' : '';
  try {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Giá kim loại quý hôm nay',
      text1 + text2,
      platformChannelSpecifics,
    );
  } catch (e) {
    log('Error canceling notifications: $e');
  }
}
