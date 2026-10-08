import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/services/supabase_service.dart';

class RewardedAdService {
  RewardedAd? _ad;
  bool _loading = false;

  static const testAndroidAdUnit = 'ca-app-pub-3940256099942544/5224354917';

  Future<void> preload() async {
    if (_loading || _ad != null) return;
    _loading = true;
    await RewardedAd.load(
      adUnitId: const String.fromEnvironment(
        'ADMOB_REWARDED_AD_UNIT_ID',
        defaultValue: testAndroidAdUnit,
      ),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _loading = false;
        },
        onAdFailedToLoad: (_) {
          _loading = false;
          _ad = null;
        },
      ),
    );
  }

  Future<String?> show() async {
    await preload();
    final ad = _ad;
    final user = SupabaseService.client?.auth.currentUser;
    if (ad == null) return 'الإعلان غير متاح الآن، حاول مرة أخرى.';
    _ad = null;

    if (user != null) {
      ad.setServerSideOptions(
        ServerSideVerificationOptions(customData: user.id),
      );
    }

    final completer = Completer<String?>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        preload();
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        preload();
      },
    );

    ad.show(
      onUserEarnedReward: (adWithoutView, reward) async {
        final client = SupabaseService.client;
        if (client == null || user == null) {
          if (!completer.isCompleted) completer.complete('شاهدت إعلانًا تجريبيًا. سجّل الدخول لاحتساب المكافأة.');
          return;
        }
        try {
          await client.rpc('claim_rewarded_ad', params: {
            'p_user_id': user.id,
            'p_event_id': DateTime.now().microsecondsSinceEpoch.toString(),
            'p_reward_points': reward.amount.toInt(),
          });
          if (!completer.isCompleted) completer.complete('تمت إضافة المكافأة إلى رصيدك.');
        } catch (e) {
          if (!completer.isCompleted) completer.complete('تمت مشاهدة الإعلان، لكن تعذر تحديث الرصيد الآن.');
        }
      },
    );
    return completer.future;
  }
}
