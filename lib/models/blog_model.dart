//@dart=2.9

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

IgBlog welcomeFromJson(String str) => IgBlog.fromJson(json.decode(str));

String welcomeToJson(IgBlog data) => json.encode(data.toJson());

class IgBlog {
  IgBlog({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory IgBlog.fromJson(Map<String, dynamic> json) => IgBlog(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Blog> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Blog>.from(json["data"].map((x) => Blog.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Blog {
  Blog({
    this.id,
    this.slug,
    this.voice,
    this.categoryId,
    this.authorId,
    this.postId,
    this.title,
    this.blogAccentCode,
    this.tags,
    this.shortDescription,
    this.description,
    this.thumbImage,
    this.bannerImage,
    this.videoUrl,
    this.audioFile,
    this.contentType,
    this.scialMediaImage,
    this.time,
    this.isFeatured,
    this.isVotingEnable,
    this.votingQuestion,
    this.optiontype,
    this.url,
    this.tweetPublished,
    this.seoTitle,
    this.seoKeyword,
    this.seoTag,
    this.seoDescription,
    this.isSlider,
    this.isEditorPicks,
    this.isWeeklyTopPicks,
    this.createdBy,
    this.status,
    this.scheduleDate,
    this.order,
    this.viewMoreClick,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.languageCode,
    this.trimedDescription,
    this.isVote,
    this.isBookmark,
    this.viewCount,
    this.yesPercent,
    this.noPercent,
    this.authorName,
    this.image,
    this.categoryName,
    this.color,
    this.createDate,
    this.blogCategory,
  });

  int id;
  String slug;
  String voice;
  int categoryId;
  dynamic authorId;
  int postId;
  String title;
  String blogAccentCode;
  String tags;
  String shortDescription;
  String description;
  String thumbImage;
  List<String> bannerImage;
  dynamic videoUrl;
  dynamic audioFile;
  String contentType;
  String scialMediaImage;
  String time;
  int isFeatured;
  int isVotingEnable;
  String votingQuestion;
  int optiontype;
  String url;
  int tweetPublished;
  dynamic seoTitle;
  dynamic seoKeyword;
  dynamic seoTag;
  dynamic seoDescription;
  int isSlider;
  int isEditorPicks;
  int isWeeklyTopPicks;
  int createdBy;
  int status;
  DateTime scheduleDate;
  int order;
  int viewMoreClick;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String languageCode;
  String trimedDescription;
  int isVote;
  int isBookmark;
  int viewCount;
  int yesPercent;
  int noPercent;
  String authorName;
  String image;
  String categoryName;
  String color;
  String createDate;
  List<BlogCategory> blogCategory;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        slug: json["slug"],
        voice: json["voice"],
        categoryId: json["category_id"],
        authorId: json["author_id"],
        postId: json["post_id"],
        title: json["title"],
        blogAccentCode: json["blog_accent_code"],
        tags: json["tags"],
        shortDescription: json["short_description"],
        description: json["description"],
        thumbImage: json["thumb_image"],
        bannerImage: List<String>.from(json["banner_image"].map((x) => x)),
        videoUrl: json["video_url"],
        audioFile: json["audio_file"],
        contentType: json["content_type"],
        scialMediaImage: json["scial_media_image"],
        time: json["time"],
        isFeatured: json["is_featured"],
        isVotingEnable: json["is_voting_enable"],
        votingQuestion: json["VotingQuestion"],
        optiontype: json["optiontype"],
        url: json["url"],
        tweetPublished: json["tweet_published"],
        seoTitle: json["seo_title"],
        seoKeyword: json["seo_keyword"],
        seoTag: json["seo_tag"],
        seoDescription: json["seo_description"],
        isSlider: json["is_slider"],
        isEditorPicks: json["is_editor_picks"],
        isWeeklyTopPicks: json["is_weekly_top_picks"],
        createdBy: json["created_by"],
        status: json["status"],
        scheduleDate: DateTime.parse(json["schedule_date"]),
        order: json["order"],
        viewMoreClick: json["view_more_click"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        languageCode: json["language_code"],
        trimedDescription: json["trimed_description"],
        isVote: json["is_vote"],
        isBookmark: json["is_bookmark"],
        viewCount: json["view_count"],
        yesPercent: json["yes_percent"],
        noPercent: json["no_percent"],
        authorName: json["author_name"],
        image: json["image"],
        categoryName: json["category_name"],
        color: json["color"],
        createDate: json["create_date"],
        blogCategory: List<BlogCategory>.from(
            json["blog_category"].map((x) => BlogCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "voice": voice,
        "category_id": categoryId,
        "author_id": authorId,
        "post_id": postId,
        "title": title,
        "blog_accent_code": blogAccentCode,
        "tags": tags,
        "short_description": shortDescription,
        "description": description,
        "thumb_image": thumbImage,
        "banner_image": List<dynamic>.from(bannerImage.map((x) => x)),
        "video_url": videoUrl,
        "audio_file": audioFile,
        "content_type": contentType,
        "scial_media_image": scialMediaImage,
        "time": time,
        "is_featured": isFeatured,
        "is_voting_enable": isVotingEnable,
        "VotingQuestion": votingQuestion,
        "optiontype": optiontype,
        "url": url,
        "tweet_published": tweetPublished,
        "seo_title": seoTitle,
        "seo_keyword": seoKeyword,
        "seo_tag": seoTag,
        "seo_description": seoDescription,
        "is_slider": isSlider,
        "is_editor_picks": isEditorPicks,
        "is_weekly_top_picks": isWeeklyTopPicks,
        "created_by": createdBy,
        "status": status,
        "schedule_date": scheduleDate.toIso8601String(),
        "order": order,
        "view_more_click": viewMoreClick,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "language_code": languageCode,
        "trimed_description": trimedDescription,
        "is_vote": isVote,
        "is_bookmark": isBookmark,
        "view_count": viewCount,
        "yes_percent": yesPercent,
        "no_percent": noPercent,
        "author_name": authorName,
        "image": image,
        "category_name": categoryName,
        "color": color,
        "create_date": createDate,
        "blog_category":
            List<dynamic>.from(blogCategory.map((x) => x.toJson())),
      };
}

class BlogCategory {
  BlogCategory({
    this.id,
    this.categoryId,
    this.blogId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.category,
  });

  int id;
  int categoryId;
  int blogId;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  Category category;

  factory BlogCategory.fromJson(Map<String, dynamic> json) => BlogCategory(
        id: json["id"],
        categoryId: json["category_id"],
        blogId: json["blog_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "blog_id": blogId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "category": category.toJson(),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.color,
    this.order,
    this.status,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String name;
  String slug;
  String image;
  String color;
  int order;
  int status;
  int isFeatured;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        color: json["color"],
        order: json["order"],
        status: json["status"],
        isFeatured: json["is_featured"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "color": color,
        "order": order,
        "status": status,
        "is_featured": isFeatured,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
