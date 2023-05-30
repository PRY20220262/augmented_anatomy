import 'package:augmented_anatomy/models/recent_activity_item.dart';

class MainMenuModel {

  int? userId;
  List<RecentActivityItem>? recentActivityList;
  RecentActivityItem? recommendation;
  int? noteCount;
  int? quizCount;

  MainMenuModel({this.userId, this.recentActivityList, this.recommendation, this.noteCount, this.quizCount});

  MainMenuModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    recentActivityList = <RecentActivityItem>[];
    json['recentActivity'].forEach((v) {
      recentActivityList?.add(RecentActivityItem.fromJson(v));
    });
    recommendation = RecentActivityItem.fromJson(json['recommendation']);
    noteCount = json["noteCount"];
    quizCount = json ["quizCount"];

  }

}
