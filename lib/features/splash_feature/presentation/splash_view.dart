import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/gen/assets.gen.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/widgets/circular_indicator_widget.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SharedBloc>().add(LoadThemeMode());
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SharedBloc, SharedState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Assets.images.logoDark.svg(
                  width: 300,
                  height: 300,
                  placeholderBuilder: (context) =>
                      const CircularIndicatorWidget(),
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Text(
                'Mind Write',
                style: TextStyle(
                    color: AppColorConstants.primaryDarkColor,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          );
        },
      ),
    );
  }
}
