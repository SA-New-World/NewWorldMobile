import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({super.key, required this.searchController, required void this.onSearch(String text)});
  final TextEditingController searchController;
  Function onSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
            )
          ),
          IconButton(
            onPressed: () => onSearch(searchController.text),
            icon: const Icon(Icons.search)
          )
        ],
      ),
    );
  }
}