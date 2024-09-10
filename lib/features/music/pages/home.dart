import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Ionicons.search)),
                    _buildLogo(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Ionicons.menu))
                  ],
                ),
              ),
            ),
            // bottom: PreferredSize(
            //     preferredSize: const Size.fromHeight(100),
            //     child: Container(
            //       height: 100,
            //       width: double.infinity,
            //       decoration: BoxDecoration(
            //           color: AppColors.primary,
            //           borderRadius: BorderRadius.circular(30)),
            //     )),
          ),
        ],
      ),
    );
  }

  SvgPicture _buildLogo() {
    return SvgPicture.asset(height: 33, AppVectors.logo);
  }
}
