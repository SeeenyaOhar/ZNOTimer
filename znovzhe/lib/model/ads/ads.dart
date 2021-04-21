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
    return interstitialAd;
  }

  static void initFirebaseAdmob() {
    MobileAds.instance.initialize();
    _isInit = true;
  }
}

class DefaultInterstitialHandler {
  InterstitialAd interstitial;

  void initAd() {
    var listener = (Ad ad) {
      print("Ad loaded!");
      interstitial.show();
    };
    interstitial =
        AdmobHelper.createInterstitial(DefaultInterstitialListener(listener));
  }

  void load() {
    interstitial.load();
  }
}
class DefaultInterstitialListener extends AdListener {
  Function(Ad ad) onAdLoadedFun;
  static final Function(Ad ad) onAdLoadedDefault =
      (Ad ad) => print("Ad loaded");

  DefaultInterstitialListener(Function(Ad ad) onAdLoaded) {
    onAdLoadedFun = onAdLoaded;
  }

  @override
  void Function(Ad ad) get onAdClosed => (Ad ad) {
        ad.dispose();
        print("Ad closed");
      };

  @override
  void Function(Ad ad, LoadAdError error) get onAdFailedToLoad =>
      (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad failed to load: $error');
      };

  @override
  void Function(Ad ad) get onAdLoaded => (Ad ad) => onAdLoadedFun(ad);

  @override
  void Function(Ad ad) get onAdOpened => (Ad ad) => print('Ad opened.');

  @override
  void Function(Ad ad) get onApplicationExit =>
      (Ad ad) => print('Left application.');
}


