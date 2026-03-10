import 'package:flutter/material.dart';
import 'package:power_gym/features/home/presentation/view/widget/member_tile.dart';

import '../../../../members/data/models/member_model/member_model.dart';

class SearchDropdownOverlay {
  static OverlayEntry create({
    required BuildContext context,
    required Offset offset,
    required Size size,
    required LayerLink layerLink,
    required List<MemberModel> filtered,
    required VoidCallback removeOverlay,
    required Function(MemberModel) onMemberSelected,
  }) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: removeOverlay,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 5,
            width: size.width,
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 5),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final member = filtered[index];

                      return MemberTile(
                        onTap: () => onMemberSelected(member),
                        memberName: member.name,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
