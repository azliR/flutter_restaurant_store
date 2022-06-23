import 'package:flutter/material.dart';

class NeedCompletionWidget extends StatelessWidget {
  const NeedCompletionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FlutterLogo(size: 64),
              const SizedBox(height: 8),
              Text(
                'Your account need to be completed before you can view this page',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                child: const Text('Complete profile'),
                onPressed: () {
                  // context.tabsRouter.setActiveIndex(HomeSection.account.index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
