import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<HomeViewModel>(
      view: () => const _HomeView(),
      viewModel: HomeViewModel(),
    );
  }
}

class _HomeView extends StatelessView<HomeViewModel> {
  const _HomeView();
  @override
  Widget render(BuildContext context, viewModel) {
    return Scaffold();
  }
}
