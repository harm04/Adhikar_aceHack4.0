
import 'package:adhikar_acehack4_o/common/widgets/error.dart';
import 'package:adhikar_acehack4_o/common/widgets/loader.dart';
import 'package:adhikar_acehack4_o/features/home/controller/search_controller.dart';
import 'package:adhikar_acehack4_o/features/home/widgets/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => setState(() {
            isShowUsers = true;
          }),
          controller: _searchController,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                _searchController.clear();
              },
              child: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            ),
            hintText: 'Search here...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: isShowUsers
          ? ref.watch(searchUserProvider(_searchController.text)).when(
              data: (searchUser) {
                return ListView.builder(
                    itemCount: searchUser.length,
                    itemBuilder: (context, index) {
                      return SearchCard(user: searchUser[index]);
                    });
              },
              error: (error, st) => ErrorText(error: error.toString()),
              loading: () => LoadingPage())
          : SizedBox(),
    );
  }
}
