
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class FirebaseAnalyticsService {

  FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  init() {
    FirebaseAnalyticsObserver appAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);
  }



}