import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';

class AdManager {
  MobileAdTargetingInfo _targetInfo;
  static BannerAd bannerAd;
  static InterstitialAd myInterstitial;
  String testDevices = "F4A2F26BCEFE2366493A82D4711D4BE9";

  AdManager() {
    _targetInfo = MobileAdTargetingInfo(
      testDevices: testDevices != null ? <String>[testDevices] : null,
      keywords: <String>['anime', 'game', 'music'],
      nonPersonalizedAds: true,
    );
  }

  loadBannerAd() {
    bannerAd = BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: _targetInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded)
            showBannerAd();
          else if (event == MobileAdEvent.closed) loadBannerAd();
        });
    showBannerAd();
  }

  showBannerAd() {
    bannerAd
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 60,
      );
  }

  static void closeBannerAd() {
    if (bannerAd != null) bannerAd.dispose();
  }

  static String get appID {
    if (Platform.isAndroid)
      return "ca-app-pub-6938134630901841~8651721888";
    else if (Platform.isIOS)
      return "<YOUR_IOS_APP_ID>";
    else
      throw Exception("Unsuported Platform");
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6938134630901841/7282622283";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
