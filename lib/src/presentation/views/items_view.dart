import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sailors/src/config/localization/app_localizations.dart';
import 'package:sailors/src/domain/entities/item.dart';
import 'package:sailors/src/injector.dart';
import 'package:sailors/src/presentation/blocs/remote_items/remote_items_bloc.dart';
import '../../core/bloc/bloc_with_state.dart';
import '../blocs/remote_items/remote_items_event.dart';
import '../blocs/remote_items/remote_items_state.dart';
import '../widgets/item_widget.dart';

class ItemsView extends HookWidget {
  const ItemsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remoteArticleBloc = BlocProvider.of<RemoteItemsBloc>(context);
    final state = remoteArticleBloc.blocProcessState;

    if (state == BlocProcessState.idle) {
      remoteArticleBloc.add(const GetItems());
    }
    return BlocProvider<RemoteItemsBloc>(
        create: (_) =>
        injector()..add(const GetItems()),
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(),
        )
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    title: Text(AppLocalizations.of(context).translate('title'),
        style: const TextStyle(color: Colors.black)),
    actions: [
      Builder(
        builder: (context) =>
            GestureDetector(
              onTap: () => _onShowSavedArticlesViewTapped(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(Ionicons.bookmark, color: Colors.black),
              ),
            ),
      ),
    ],
  );
}

Widget _buildBody() {
  return BlocBuilder<RemoteItemsBloc, RemoteItemsState>(
    builder: (_, state) {
      if (state is RemoteItemsLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RemoteItemsError) {
        return const Center(child: Icon(Ionicons.refresh));
      }
      if (state is RemoteItemsDone) {
        return _buildArticle(state.items!);
      }
      return const SizedBox();
    },
  );
}

Widget _buildArticle(List<Item> articles) {
  return ListView(children: [
    // Items
    ...List<Widget>.from(
      articles.map(
            (e) =>
            Builder(
              builder: (context) =>
                  ArticleWidget(
                    item: e,
                    onArticlePressed: (e) => _onArticlePressed(context, e),
                  ),
            ),
      ),
    ),

    // add Loading (circular progress indicator at the end),
    // if there are more items to be loaded
    const SizedBox()
  ]);
}

void _onScrollListener(BuildContext context,
    ScrollController scrollController,
    RemoteItemsBloc remoteArticleBloc,
    BlocProcessState state) {
  final maxScroll = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.position.pixels;
  if (currentScroll == maxScroll && state == BlocProcessState.idle) {
    remoteArticleBloc.add(const GetItems());
  }
}

void _onArticlePressed(BuildContext context, Item item) {
  Navigator.pushNamed(context, '/ArticleDetailsView', arguments: item);
}

void _onShowSavedArticlesViewTapped(BuildContext context) {
  Navigator.pushNamed(context, '/SavedArticlesView');
}
