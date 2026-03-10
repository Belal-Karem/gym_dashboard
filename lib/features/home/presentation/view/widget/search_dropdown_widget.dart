import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/get_data_member_cubit.dart';

import '../../../../members/data/models/member_model/member_model.dart';

class SearchDropdownWidget extends StatelessWidget {
  const SearchDropdownWidget({
    super.key,
    required LayerLink layerLink,
    required FocusNode focusNode,
    required TextEditingController controller,
    this.onChanged,
    this.onMembersLoaded,
  }) : _layerLink = layerLink,
       _focusNode = focusNode,
       _controller = controller;

  final LayerLink _layerLink;
  final FocusNode _focusNode;
  final TextEditingController _controller;
  final void Function(String)? onChanged;
  final void Function(List<MemberModel>)? onMembersLoaded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataMemberCubit, GetDataMemberState>(
      builder: (context, state) {
        if (state is GetDataMemberLoaded) {
          onMembersLoaded?.call(state.members);
        }

        return CompositedTransformTarget(
          link: _layerLink,
          child: TextField(
            focusNode: _focusNode,
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'بحث',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: onChanged,
          ),
        );
      },
    );
  }
}
