class MembersCountMode {
  final int men;
  final int women;
  final int children;
  final int active;
  final int expired;

  const MembersCountMode({
    required this.men,
    required this.women,
    required this.children,
    required this.active,
    required this.expired,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MembersCountMode &&
            men == other.men &&
            women == other.women &&
            children == other.children &&
            active == other.active &&
            expired == other.expired;
  }

  @override
  int get hashCode =>
      men.hashCode ^
      women.hashCode ^
      children.hashCode ^
      active.hashCode ^
      expired.hashCode;
}
