abstract class AllCommentsState {}

class AllCommentsInitial extends AllCommentsState {}

class AllCommentsLoading extends AllCommentsState {}

class AllCommentsLoaded extends AllCommentsState {
  final List comments;
  AllCommentsLoaded(this.comments);
}

class AllCommentsSuccess extends AllCommentsState {}

class AllCommentsError extends AllCommentsState {
  final String message;
  AllCommentsError(this.message);
}
