//@dart=2.9

import 'package:incite/models/blog_category.dart';

class BlogListHolder {
  List<Blog> _list = [];
  int _index = 0;

  int getIndex() => _index;
  List<Blog> getList() => _list;

  void setIndex(int index) {
    this._index = index;
  }

  void setList(List<Blog> list) {
    this._list = list;
  }

  void clearList() {
    this._list = new List();
  }
}

BlogListHolder blogListHolder = new BlogListHolder();
