import './styles.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  List<String> _list;
  List<String> _cachedList;

  DataSearch(List<String> list) {
    this._list = list.toSet().toList();
    this._list.sort();
    this._cachedList = this._list.sublist(0, 10);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Styles.textColorDefaultInverse,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Styles.textColorDefaultInverse,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? _cachedList
        : _list
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
          showResults(context);
        },
        leading: Icon(Icons.local_offer,),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: Styles.textSearchFocus,
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: Styles.textSearchUnfocus,
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
