import 'package:boilerplate/constants/index.dart';
import 'package:boilerplate/models/post/index.dart';
import 'package:boilerplate/utils/index.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/sharedpref/constants/preferences.dart';
import '../../locale/index.dart';
import '../../routes.dart';
import '../../stores/post/post_store.dart';
import '../../widgets/progress_indicator_widget.dart';

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
        if (MediaQuery.of(context).orientation == Orientation.landscape &&
            dimens.maxWidth >= Dimens.tablet_breakpoint) {
          return Row(
            children: <Widget>[
              Container(
                width: Dimens.tablet_list_width,
                child: Stack(
                  children: <Widget>[
                    Observer(
                      builder: (context) {
                        return _store.loading
                            ? CustomProgressIndicatorWidget()
                            : Material(
                                child: _buildListView((val) {
                                if (mounted)
                                  setState(() {
                                    _selectedIndex = val;
                                  });
                              }, true));
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
              ),
              Expanded(
                child:
                    _store?.postsList?.posts == null || _selectedIndex == null
                        ? Center(
                            child: Text(Provider.of<LocaleState>(context)
                                .strings
                                .post_not_selected))
                        : PostDetailsScreen(
                            post: _store.postsList.posts[_selectedIndex],
                            showAppBar: false,
                          ),
              ),
            ],
          );
        }
        return Stack(
          children: <Widget>[
            Observer(
              builder: (context) {
                return _store.loading
                    ? CustomProgressIndicatorWidget()
                    : Material(
                        child: _buildListView((val) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PostDetailsScreen(
                                  post: _store.postsList.posts[val],
                                ),
                          ),
                        );
                      }, false));
              },
            ),
            Observer(
              name: 'error',
              builder: (context) {
                return _store.success
                    ? Container()
                    : showErrorMessage(context, _store.errorStore.errorMessage);
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildListView(ValueChanged<int> selected, bool tablet) {
    return _store.postsList != null
        ? ListView.separated(
            itemCount: _store.postsList.posts.length,
            separatorBuilder: (context, position) {
              return Divider();
            },
            itemBuilder: (context, position) {
              return ListTile(
                selected: tablet ? _selectedIndex == position : false,
                leading: Icon(Icons.cloud_circle),
                title: Text(
                  '${_store.postsList.posts[position].title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  '${_store.postsList.posts[position].body}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                onTap: () => selected(position),
              );
            },
          )
        : Center(
            child: Text(
                Provider.of<LocaleState>(context).strings.posts_not_found));
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
