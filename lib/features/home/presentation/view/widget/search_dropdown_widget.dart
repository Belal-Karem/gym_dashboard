import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/view/widget/show_dialog_data_Member_info.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

class SearchDropdownWidget extends StatefulWidget {
  final List<MemberModel> members;

  const SearchDropdownWidget({super.key, required this.members});

  @override
  State<SearchDropdownWidget> createState() => _SearchDropdownWidgetState();
}

class _SearchDropdownWidgetState extends State<SearchDropdownWidget> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController();

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
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox.expand(),
            ),
          ),
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
                        setState(() {
                          _controller.text = member.name;
                          filtered.clear();
                        });
                        _removeOverlay();
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              child: BlocProvider.value(
                                value: context.read<AttendanceCubit>(),
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
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: 'بحث',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          setState(() {
            filtered = widget.members
                .where(
                  (member) =>
                      member.name.toLowerCase().startsWith(value.toLowerCase()),
                )
                .toList();
          });
          _updateOverlay();
        },
        onTap: () {
          if (filtered.isNotEmpty) _updateOverlay();
        },
        onEditingComplete: _removeOverlay,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _removeOverlay();
    super.dispose();
  }
}
