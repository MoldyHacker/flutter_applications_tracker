import 'package:flutter/material.dart';

class ApplicationCardListItems extends StatelessWidget {
  final double itemHeight;
  final double displayedItems;
  final List<Map<String, String>> listItems;
  final void Function() onPressed;

  const ApplicationCardListItems({
    super.key,
    required this.listItems,
    required this.onPressed,
    required this.itemHeight,
    required this.displayedItems,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displayedItems * itemHeight,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: itemHeight,
            color: Theme.of(context).highlightColor,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Text(
                                listItems[0]['date'] ?? 'Date',
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  listItems[0]['description'] ?? 'Description',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onPressed,
                        icon: const Icon(
                          Icons.keyboard_arrow_right_outlined,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.0,
                    height: 1.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
