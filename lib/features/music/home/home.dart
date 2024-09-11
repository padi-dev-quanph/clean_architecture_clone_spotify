import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/helpers/is_dark_mode.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_images.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/features/music/home/widgets/song_item.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  final List<String> tabs = [
    'News',
    'Video',
    'Artists',
    'Podcasts',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: BasicAppbar(
          leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                  height: 25,
                  width: 25,
                  AppVectors.icSearch,
                  colorFilter: const ColorFilter.mode(
                      AppColors.darkGrey, BlendMode.srcIn))),
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 33,
          ),
          action: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              height: 25,
              width: 25,
              AppVectors.icMore,
              colorFilter:
                  const ColorFilter.mode(AppColors.darkGrey, BlendMode.srcIn),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _homeTopCard(),
              _tabs(),
              SizedBox(
                height: 270,
                child: TabBarView(
                  controller: _tabController,
                  children: tabs.map((tab) => _buildSongCollection()).toList(),
                ),
              ),
              _playlist()
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 188,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.homeTopCard)),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Image.asset(AppImages.homeArtist),
                ))
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      indicator: null,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      dividerHeight: 0,
      indicatorColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
      tabs: tabs.mapIndexed((index, tab) {
        return Tab(
          child: Text(tab,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: selectedIndex == index
                      ? AppColors.textGreyLight
                      : AppColors.textGreyDark)),
        );
      }).toList(),
    );
  }

  Widget _buildSongCollection() {
    return Container(
      height: 270,
      margin: const EdgeInsets.only(left: 20),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return const SongItem();
        },
      ),
    );
  }

  Widget _playlist() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Playlist',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ))
            ],
          ),
          Column(
            children: List.generate(1, (index) {
              return ListTile(
                leading: Container(
                  height: 29,
                  width: 29,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                          ? AppColors.textGreyLight
                          : AppColors.textGreyDark),
                  child: Center(
                    child: SvgPicture.asset(
                        height: 14, width: 14, AppVectors.btnPlay),
                  ),
                ),
                title: const Text(
                  'As It Was',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Harry Styles',
                  style: TextStyle(fontSize: 14),
                ),
                trailing: const Row(
                  children: [
                    Text('5:33'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.heart_broken)
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
