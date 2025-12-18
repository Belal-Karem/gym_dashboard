class MembersCountMode {
  final int men;
  final int women;
  final int children;
  final int active;
  final int expired;
  final int? total;

  MembersCountMode({
    this.total,
    required this.men,
    required this.women,
    required this.children,
    required this.active,
    required this.expired,
  });
}
