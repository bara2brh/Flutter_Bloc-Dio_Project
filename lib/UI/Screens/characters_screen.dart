import 'package:bloc_pattern_api_practice/Business_Logic/cubit/characters_cubit.dart';
import 'package:bloc_pattern_api_practice/Constants/colors.dart';
import 'package:bloc_pattern_api_practice/UI/Widgets/character_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/Models/character.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> allCharacters = [];
  List<Character> searchedCharacters = [];
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllChahracters();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      decoration: InputDecoration(
          hintText: 'Find a character ....',
          border: InputBorder.none,
          hintStyle:
              TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 18),
          focusedBorder: InputBorder.none),
      onChanged: (searchValue) {
        addItemsToSearchedList(searchValue.toLowerCase());
      },
    );
  }

  void addItemsToSearchedList(String searchValue) {
    searchedCharacters = allCharacters
        .where(
            (character) => character.name.toLowerCase().startsWith(searchValue))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(builder: (ctx, state) {
      if (state is CharactersLoaded) {
        allCharacters = state.characters;
        return buildLoadedListWidgets();
      } else {
        return showLoading();
      }
    });
  }

  Widget showLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.appGreen,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.appGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        itemCount: _searchController.text.isNotEmpty
            ? searchedCharacters.length
            : allCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
              character: _searchController.text.isNotEmpty
                  ? searchedCharacters[index]
                  : allCharacters[index]);
        });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Rick And Morty Characters',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appGrey,
        appBar: AppBar(
          backgroundColor: AppColors.appGreen,
          title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
          leading: _isSearching
              ? const BackButton(
                  color: Colors.white,
                )
              : null,
          actions: _buildAppBarActions(),
        ),
        body: buildBlockWidget());
  }
}
