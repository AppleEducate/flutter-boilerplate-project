import 'package:boilerplate/constants/index.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../locale/index.dart';
import '../../models/post/index.dart';
import '../../stores/post/post_store.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';
import '../../widgets/progress_indicator_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //store
  final _store = PostStore();

  @override
  void initState() {
    super.initState();

    //get all posts
    _store.getPosts();
  }

  int _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimens) {
        final _tablet =
            MediaQuery.of(context).orientation == Orientation.landscape &&
                dimens.maxWidth >= Dimens.tablet_breakpoint;

        return Container(
          child: Stack(
            children: <Widget>[
              Observer(
                builder: (context) {
                  return MasterDetailView.builder(
                    itemCount: _store?.postsList?.posts?.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: ListTile(
                          selected: _tablet ? _selectedIndex == index : false,
                          leading: Icon(Icons.cloud_circle),
                          title: Text(
                            '${_store.postsList.posts[index].title}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context).textTheme.title,
                          ),
                          subtitle: Text(
                            '${_store.postsList.posts[index].body}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                        actions: <Widget>[
                          IconSlideAction(
                            caption: 'Archive',
                            color: Colors.blue,
                            icon: Icons.archive,
                            onTap: () => _showSnackBar('Archive'),
                          ),
                          IconSlideAction(
                            caption: 'Share',
                            color: Colors.indigo,
                            icon: Icons.share,
                            onTap: () => _showSnackBar('Share'),
                          ),
                        ],
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'More',
                            color: Colors.black45,
                            icon: Icons.more_horiz,
                            onTap: () => _showSnackBar('More'),
                          ),
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () => _showSnackBar('Delete'),
                          ),
                        ],
                      );
                    },
                    detailsBuilder: (context, index, tablet) {
                      return PostDetailsScreen(
                        showAppBar: !tablet,
                        post: _store.postsList.posts[index],
                      );
                    },
                    selectedIndex: _selectedIndex,
                    onSelected: (val) {
                      if (mounted)
                        setState(() {
                          _selectedIndex = val;
                        });
                    },
                    itemNotSelected: Center(
                      child: Text(Provider.of<LocaleState>(context)
                          .strings
                          .post_not_selected),
                    ),
                    itemsNull: CustomProgressIndicatorWidget(),
                    itemsEmpty: Center(
                      child: Text(Provider.of<LocaleState>(context)
                          .strings
                          .posts_not_found),
                    ),
                  );
                },
              ),
              Observer(
                name: 'error',
                builder: (context) {
                  return _store.success
                      ? Container()
                      : showErrorMessage(
                          context, _store.errorStore.errorMessage);
                },
              )
            ],
          ),
        );
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  showErrorMessage(BuildContext context, String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null) {
        FlushbarHelper.createError(
          message: message,
          title: 'Error',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return Container();
  }

  _showSnackBar(String s) {
    FlushbarHelper.createInformation(
      message: s,
      title: 'Info',
      duration: Duration(seconds: 3),
    )..show(context);
  }
}

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({
    @required this.post,
    this.showAppBar = true,
  });
  final Post post;
  final bool showAppBar;
  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text('Details'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_alert),
                  onPressed: () {
                    Notifications.show(
                      context,
                      id: post.id,
                      title: post.title,
                      body: post.body,
                      payload: "${post.title}\n\n${post.body}",
                    );
                  },
                )
              ],
            )
          : null,
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              post.title,
              style: _textTheme.title,
            ),
          ),
          ListTile(
            title: Text(
              post.body,
              style: _textTheme.subtitle,
            ),
          ),
        ],
      ),
    );
  }
}
