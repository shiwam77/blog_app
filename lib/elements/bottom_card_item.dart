//@dart=2.9

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:incite/data/blog_list_holder.dart';
import 'package:incite/pages/SwipeablePage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../app_theme.dart';
// import 'package:incite/models/blog_category.dart';
import '../models/blog_model.dart';

//* <------- Bottom card of home page ------->

class BottomCard extends StatelessWidget {
  final Function ontap;
  final Blog item;
  final bool isTrending;
  final int index;
  final List<Blog> blogList;
  var height, width;
  BottomCard(this.item, this.index, this.blogList,
      {this.isTrending = false, this.ontap});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      child: Center(
        child: Container(
          width: double.infinity,
          height: 0.2 * height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).cardColor,
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.black38.withOpacity(0.1),
            //       blurRadius: 10.0,
            //       offset: Offset(0.0, 5.0),
            //       spreadRadius: 2.0)
            // ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              print("constraints ${constraints.maxWidth}");

              return Stack(
                children: <Widget>[
                  _buildContents(context, height, constraints.maxWidth),
                  Positioned(
                    bottom: 0.03 * height,
                    right: 0.03 * width,
                    child: isTrending
                        ? Image.asset(
                            "assets/img/trending.png",
                            height: 20,
                            width: 20,
                          )
                        : Container(),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          // Navigator.of(context)
                          // .pushNamed("/ReadBlog", arguments: item);
                          if (ontap != null) {
                            ontap();
                          }
                          blogListHolder.setList(blogList);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SwipeablePage(index),
                          ));
                        },
                      ),
                    ),
                  ),
                  //Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

//? Split the build method into smaller components for better reading

  _buildContents(BuildContext context, var height, var width) {
    //print(constraints);
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 5.0, bottom: 0.0, right: 5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                height: 0.2 * height * 0.85,
                width: 0.2 * height * 0.85,
                // height: 0.2 * height,
                // width: 0.18 * height,
                child: Image.network(
                  item.bannerImage[0],
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                )),
          ),
        ),
        _buildTextAndUserWidget(context, width)
      ],
    );
  }

  _buildTextAndUserWidget(BuildContext context, var width) {
    //print("Image Size ${0.2 * height * 0.85}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              width: 0.5 * width,
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.bodyText1.merge(
                      TextStyle(
                          color: appThemeModel.value.isDarkModeEnabled.value
                              ? Colors.white
                              : Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal),
                    ),
                //style: TextStyle(fontSize: 18.0, color: Colors.black),
                //style: Theme.of(context).textTheme.subtitle1,
                //style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          Spacer(),

          Container(
            width: width * 0.53,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 4.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 0.035 * width,
                          height: 0.035 * width,
                          decoration: new BoxDecoration(
                            color: HexColor(item.color.toString()),
                            //color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          item.categoryName,
                          style: Theme.of(context).textTheme.bodyText1.merge(
                                TextStyle(
                                    color: appThemeModel
                                            .value.isDarkModeEnabled.value
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal),
                              ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 0.19 * width,
                  // ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      MdiIcons.eye,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    item.viewCount.toString(),
                    style: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: appThemeModel.value.isDarkModeEnabled.value
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: 'Montserrat',
                              fontSize: 13.0,
                              fontWeight: FontWeight.normal),
                        ),
                    //style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          //Spacer()
        ],
      ),
    );
  }
}
