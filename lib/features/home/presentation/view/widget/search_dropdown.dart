import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/home/presentation/view/widget/show_member_dialog.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/peivate/presentation/manger/cubit/private_cubit.dart';

import 'search_dropdown_overlay.dart';
import 'search_dropdown_widget.dart';

class SearchDropdown extends StatefulWidget {
  const SearchDropdown({super.key});

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController();

  List<MemberModel> members = [];
  List<MemberModel> filtered = [];
  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
      }
    });
    context.read<PrivateCubit>().loadPrivate();
  }

  List<MemberModel> _filterMembers(String value) {
    final search = value.toLowerCase();

    return members.where((m) {
      return m.memberId.toLowerCase().startsWith(search) ||
          m.phone.toLowerCase().startsWith(search) ||
          m.name.toLowerCase().startsWith(search);
    }).toList();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (value.isEmpty) {
        _clearSearch();
        return;
      }

      filtered = _filterMembers(value);
      _updateOverlay();
    });
  }

  void _clearSearch() {
    _controller.clear();
    filtered.clear();
    _removeOverlay();
  }

  void _updateOverlay() {
    _removeOverlay();

    if (filtered.isNotEmpty && mounted) {
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

    return _overlayEntry = SearchDropdownOverlay.create(
      context: context,
      offset: offset,
      size: size,
      layerLink: _layerLink,
      filtered: filtered,
      removeOverlay: _removeOverlay,
      onMemberSelected: _onMemberSelected,
    );
  }

  void _onMemberSelected(MemberModel member) {
    _removeOverlay();

    context.read<MemberSubscriptionCubit>().getMemberSubscriptions(member.id);

    showDialog(
      context: context,
      builder: (_) {
        return ShowMemberDialog(member: member);
      },
    ).then((_) {
      _clearSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchDropdownWidget(
      layerLink: _layerLink,
      focusNode: _focusNode,
      controller: _controller,
      onChanged: _onSearchChanged,
      onMembersLoaded: (data) {
        members = data;
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }
}
