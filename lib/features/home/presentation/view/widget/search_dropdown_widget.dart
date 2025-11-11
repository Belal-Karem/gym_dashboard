import 'package:flutter/material.dart';
import 'package:power_gym/features/home/presentation/view/widget/show_dialog_data_Member_info.dart';

class SearchDropdownWidget extends StatefulWidget {
  const SearchDropdownWidget({super.key});

  @override
  State<SearchDropdownWidget> createState() => _SearchDropdownWidgetState();
}

class _SearchDropdownWidgetState extends State<SearchDropdownWidget> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController();

  final List<String> usernames = [
    'Ahmed',
    'Mohamed',
    'Ibrahim',
    'Omar',
    'Youssef',
    'Mostafa',
    'Khaled',
    'Mahmoud',
    'Walid',
    'Sami',
    'Fady',
    'Karim',
    'Ali',
    'Tamer',
    'Nader',
    'Essam',
    'Sherif',
    'Gamal',
    'Wael',
    'Mina',
    'Rami',
    'Hossam',
    'Taha',
    'Bassem',
    'Emad',
    'Samir',
    'Ayman',
    'Yasin',
    'Adel',
    'Fouad',
    'Ziad',
    'Amr',
    'Saad',
    'Anas',
    'Belal',
    'Hazem',
    'Nabil',
    'Farid',
    'Sameh',
    'Kareem',
    'Hany',
    'Tariq',
    'Majed',
    'Raouf',
    'Islam',
    'Marwan',
    'Osama',
    'Reda',
    'Shady',
    'Lotfy',
    'Bassel',
  ];

  List<String> filtered = [];
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
                    return ListTile(
                      title: Text(filtered[index]),
                      onTap: () {
                        setState(() {
                          _controller.text = filtered[index];
                          filtered.clear();
                        });
                        _removeOverlay();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(child: ShowDialogDataMemberInfo());
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
        cursorColor: Colors.white,
        controller: _controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: 'بحث',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: const Icon(Icons.search),
        ),

        onChanged: (value) {
          filtered = usernames
              .where(
                (name) => name.toLowerCase().startsWith(value.toLowerCase()),
              )
              .toList();
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
