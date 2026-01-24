import 'package:flutter/material.dart';

// ✅ Firebase Collections
const kMemberCollections = 'member';
const kSubCollections = 'plan';
const ktrainerCollections = 'trainers';
const kpaymentCollections = 'payment';
const kmembersubscriptionsCollections = 'member_subscriptions';
const kplanCollections = 'planAndPackages';
const kguestvisitsCollections = 'guest_visits';

// ✅ Member Fields
const kmemberid = 'memberId';
const kname = 'name';
const kPhone = 'phone';
const kattendance = 'attendance';
const kabsence = 'absence';
const kStartdate = 'startdata';
const kenddate = 'enddata';
const knote = 'note';
const kgender = 'gender';
const kdate = 'date';
const kaffiliationdate = 'affiliationdate';

// ✅ Subscription Fields
const kduration = 'duration';
const kfreeze = 'freeze';
const kinvitation = 'invitation';
const kmaxAttendance = 'maxAttendance';
const kprice = 'price';
const kstatus = 'status';
const ktype = 'type';

// ✅ Trainer Fields
const kptNumber = 'ptNumber';

// ✅ Payment Fields
const kpaid = 'paid';
const kpaymentDate = 'payment date';
const kpaymentMethod = 'payment method';
const kplan = 'plan';

// ✅ Plan Fields
const ksession = 'session';
const ktrainerid = 'trainerId';

// ✅ UI Colors
const kprimaryColor = Colors.black;

// Color(0xff1B1C20)
enum SubscriptionStatus { active, frozen, expired }

extension SubscriptionStatusX on SubscriptionStatus {
  String get arabicName {
    switch (this) {
      case SubscriptionStatus.active:
        return 'نشط';
      case SubscriptionStatus.frozen:
        return 'مجمّد';
      case SubscriptionStatus.expired:
        return 'منتهي';
    }
  }
}
