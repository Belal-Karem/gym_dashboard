import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  MemberCubit() : super(MemberInitial());
}
