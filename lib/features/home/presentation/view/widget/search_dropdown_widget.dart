import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/get_data_member_cubit.dart';
import 'package:power_gym/features/home/presentation/view/widget/show_dialog_data_Member_info.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

class SearchDropdownWidget extends StatefulWidget {
  const SearchDropdownWidget({super.key});

  @override
  State<SearchDropdownWidget> createState() => _SearchDropdownWidgetState();
}

class _SearchDropdownWidgetState extends State<SearchDropdownWidget> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController();

  List<MemberModel> members = [];
  List<MemberModel> filtered = [];

  OverlayEntry? _overlayEntry;

  void _updateOverlay() {
    _removeOverlay();
    if (filtered.isNotEmpty) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 👇 الجزء ده بيلقط الضغط برا القائمة
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox.expand(),
            ),
          ),
          // 👇 القائمة نفسها
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 5,
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 5),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final member = filtered[index];

                    return ListTile(
                      title: Text(member.name),
                      onTap: () {
                        _controller.text = member.name;
                        filtered.clear();
                        _removeOverlay();

                         context
                            .read<MemberSubscriptionCubit>()
                            .getMemberSubscriptions(member.id);
                            
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider.value(
                              value: context.read<MemberSubscriptionCubit>(),
                              child: Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ShowDialogDataMemberInfo(member: member),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataMemberCubit, GetDataMemberState>(
      builder: (context, state) {
        if (state is GetDataMemberLoaded) {
          members = state.members;
        }

        return CompositedTransformTarget(
          link: _layerLink,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'بحث',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              filtered = members
                  .where(
                    (m) => m.name.toLowerCase().startsWith(value.toLowerCase()),
                  )
                  .toList();
              _updateOverlay();
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _removeOverlay();
    super.dispose();
  }
}
