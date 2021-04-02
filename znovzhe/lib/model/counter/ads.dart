import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobHelper {
  static final String appId = "ca-app-pub-4486341130353955~6926543804";

  static final String interstitialAdId =
      "ca-app-pub-4486341130353955/5230318754";
  static bool _isInit = false;

  static InterstitialAd createInterstitial(AdListener listener) {
    InterstitialAd interstitialAd = InterstitialAd(
    adUnitId: AdmobHelper.interstitialAdId,
    listener: listener,
    request: AdRequest(),
    );
    return
    interstitialAd;
  }

  static void initFirebaseAdmob() {
    MobileAds.instance.initialize();
    _isInit = true;
  }
}
