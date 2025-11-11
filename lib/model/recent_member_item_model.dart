class RecentMemberItemModel {
  final int id;
  final String name, statu, mobile;

  const RecentMemberItemModel({
    required this.id,
    required this.name,
    required this.statu,
    required this.mobile,
  });

  static const List<RecentMemberItemModel> recentMemberItemModelList = [
    RecentMemberItemModel(
      id: 1,
      name: 'belal',
      statu: 'active',
      mobile: '01126062449',
    ),
    RecentMemberItemModel(
      id: 1,
      name: 'belal',
      statu: 'active',
      mobile: '01126062449',
    ),
  ];
}
