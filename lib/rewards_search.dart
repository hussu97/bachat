import './styles.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  List<String> _list;
  List<String> _cachedList;

  DataSearch(this._list, this._cachedList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Styles.colorDefaultInverse,
        ),
        onPressed: () => {query = ''},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Styles.colorDefaultInverse,
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
        : _list.where(
            (p) {
              RegExp regExp;
              if (query.length < 3) {
                regExp = new RegExp("^${query.toLowerCase()}");
                return regExp.hasMatch(p.toLowerCase());
              } else {
                regExp = new RegExp("${query.toLowerCase()}");
                return regExp.hasMatch(p.toLowerCase());
              }
            },
          ).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        int startingIdx = suggestionList[index]
            .toLowerCase()
            .indexOf(new RegExp("${query.toLowerCase()}"));
        int endIdx = startingIdx + query.length;
        return ListTile(
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
          leading: Icon(
            query.isEmpty ? Icons.history : Icons.local_offer,
          ),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: suggestionList[index].substring(0, startingIdx),
                  style: Styles.textSearchUnfocus,
                ),
                TextSpan(
                  text: suggestionList[index].substring(startingIdx, endIdx),
                  style: Styles.textSearchFocus,
                ),
                TextSpan(
                  text: suggestionList[index].substring(endIdx),
                  style: Styles.textSearchUnfocus,
                )
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
