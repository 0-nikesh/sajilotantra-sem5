import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sajilotantra/features/home/presentation/view/bottom_view/calendar.dart';
import 'package:sajilotantra/features/home/presentation/view/bottom_view/map.dart';
import 'package:sajilotantra/features/home/presentation/view/bottom_view/setting.dart';

import '../../../guidance/presentation/view/guidance_list_view.dart';
import '../view/bottom_view/first.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      views: [
        HomeScreen(),
        Calendar(),
        MapScreen(),
        GuidanceListScreen(),
        Setting(),
      ],
    );
  }

  // Copy state with changes
  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
