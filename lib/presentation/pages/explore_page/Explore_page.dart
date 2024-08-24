import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_flutter/presentation/pages/explore_page/widgets/list_widget.dart';
import 'package:task_flutter/presentation/pages/explore_page/widgets/map_widget.dart';

import '../favorite_page/Favorite_page.dart';
import '../profil_page/Profil_page.dart';
class ExplorePage extends ConsumerStatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}


class _ExplorePageState extends ConsumerState<ExplorePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color(0xFF181725),
        selectedItemColor: Color(0xFF2AA64C),
        currentIndex: _selectedIndex,
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          color: Color(0xFF181725),
          fontWeight: FontWeight.w400,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF2AA64C),
        ),
        onTap: _onItemTapped,
        backgroundColor: Color(0xFFFFFFFF),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 16,
              child: Icon(Icons.map_outlined),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 16,
              child: Icon(Icons.favorite_border),
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildExplorePage(),
          FavoritePage(),
          ProfilPage(),
          // AccountPage(),
        ],
      ),
    );
  }

  Widget _buildExplorePage() {
    return Column(
      children: [
        SizedBox(height: 60),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          padding: EdgeInsets.all(1),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(),
            labelPadding: EdgeInsets.zero,
            tabs: [
              _buildTab(
                index: 0,
                imagePath: "assets/svg/map.svg",
                label: "Map",
                isSelected: _tabController.index == 0,
              ),
              _buildTab(
                index: 1,
                imagePath: "assets/svg/map_iconlist.svg",
                label: "List",
                isSelected: _tabController.index == 1,
              ),
            ],
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              MapScreen(),
              ListPage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab({
    required int index,
    required String imagePath,
    required String label,
    required bool isSelected,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 5)]
            : [],
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Adjusts to fit the content
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            width: 24, // Adjust as needed
            height: 24, // Adjust as needed
            color: isSelected ? Colors.green : Colors.black,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.green : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}