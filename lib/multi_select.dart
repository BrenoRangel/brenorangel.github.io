import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'utils.dart';

class MultiSelect extends StatefulWidget {
  final Widget title;
  final List<String> items;
  final List<String> selectedItems;
  const MultiSelect({
    super.key,
    required this.title,
    required this.items,
    this.selectedItems = const [],
  });

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: SizedBox(
        height: kMinInteractiveDimension * 5,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: ListBody(
              children: widget.items
                  .map(
                    (item) => CheckboxListTile(
                      dense: true,
                      value: _selectedItems.contains(item),
                      contentPadding: const EdgeInsets.all(8),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MarkdownBody(data: buildTagLogo(item), imageBuilder: markdowImageBuilder),
                          Text(' $item'),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (isChecked) => _itemChange(item, isChecked!),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _clear,
          child: const Text('Limpar'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Confirmar'),
        ),
      ],
    );
  }

  @override
  void initState() {
    _selectedItems.addAll(widget.selectedItems);
    super.initState();
  }

  void _cancel() => Navigator.pop(context, widget.selectedItems);

  void _clear() => Navigator.pop(context, null);

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _submit() => Navigator.pop(context, _selectedItems);
}
