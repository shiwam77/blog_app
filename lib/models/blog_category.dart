// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

IgBlogCategory welcomeFromJson(String str) =>
    IgBlogCategory.fromJson(json.decode(str));

String welcomeToJson(IgBlogCategory data) => json.encode(data.toJson());

class IgBlogCategory {
  bool? status;
  String? message;
  List<CategoryElement>? data;

  IgBlogCategory({
    this.status,
    this.message,
    this.data,
  });

  factory IgBlogCategory.fromJson(Map<String, dynamic> json) => IgBlogCategory(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CategoryElement>.from(
                json["data"]!.map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BlogCategory {
  int? id;
  int? categoryId;
  int? blogId;
  DateTime? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  CategoryElement? category;

  BlogCategory({
    this.id,
    this.categoryId,
    this.blogId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.category,
  });

  factory BlogCategory.fromJson(Map<String, dynamic> json) => BlogCategory(
        id: json["id"],
        categoryId: json["category_id"],
        blogId: json["blog_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        category: json["category"] == null
            ? null
            : CategoryElement.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "blog_id": blogId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "category": category?.toJson(),
      };
}

class Blog {
  int? id;
  String? slug;
  String? voice;
  int? categoryId;
  dynamic authorId;
  int? postId;
  String? title;
  String? blogAccentCode;
  String? tags;
  String? shortDescription;
  String? description;
  String? thumbImage;
  List<String>? bannerImage;
  String? videoUrl;
  dynamic audioFile;
  String? contentType;
  String? scialMediaImage;
  String? time;
  int? isFeatured;
  int? isVotingEnable;
  String? votingQuestion;
  int? optiontype;
  String? url;
  int? tweetPublished;
  dynamic seoTitle;
  dynamic seoKeyword;
  dynamic seoTag;
  dynamic seoDescription;
  int? isSlider;
  int? isEditorPicks;
  int? isWeeklyTopPicks;
  int? createdBy;
  int? status;
  DateTime? scheduleDate;
  int? order;
  int? viewMoreClick;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? trimedDescription;
  int? isVote;
  int? isBookmark;
  int? viewCount;
  String? type;
  int? yesPercent;
  int? noPercent;
  String? authorName;
  String? image;
  String? categoryName;
  String? color;
  String? createDate;
  List<BlogCategory>? blogCategory;
  int? frequency;
  DateTime? startDate;
  DateTime? endDate;
  int? view;
  int? click;
  int? clickCount;
  List<Media>? media;

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
    this.trimedDescription,
    this.isVote,
    this.isBookmark,
    this.viewCount,
    this.type,
    this.yesPercent,
    this.noPercent,
    this.authorName,
    this.image,
    this.categoryName,
    this.color,
    this.createDate,
    this.blogCategory,
    this.frequency,
    this.startDate,
    this.endDate,
    this.view,
    this.click,
    this.clickCount,
    this.media,
  });

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
        bannerImage: json["banner_image"] == null
            ? []
            : List<String>.from(json["banner_image"]!.map((x) => x)),
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
        scheduleDate: json["schedule_date"] == null
            ? null
            : DateTime.parse(json["schedule_date"]),
        order: json["order"],
        viewMoreClick: json["view_more_click"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        trimedDescription: json["trimed_description"],
        isVote: json["is_vote"],
        isBookmark: json["is_bookmark"],
        viewCount: json["view_count"],
        type: json["type"],
        yesPercent: json["yes_percent"],
        noPercent: json["no_percent"],
        authorName: json["author_name"],
        image: json["image"],
        categoryName: json["category_name"],
        color: json["color"],
        createDate: json["create_date"],
        blogCategory: json["blog_category"] == null
            ? []
            : List<BlogCategory>.from(
                json["blog_category"]!.map((x) => BlogCategory.fromJson(x))),
        frequency: json["frequency"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        view: json["view"],
        click: json["click"],
        clickCount: json["click_count"],
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
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
        "banner_image": bannerImage == null
            ? []
            : List<dynamic>.from(bannerImage!.map((x) => x)),
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
        "schedule_date": scheduleDate?.toIso8601String(),
        "order": order,
        "view_more_click": viewMoreClick,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "trimed_description": trimedDescription,
        "is_vote": isVote,
        "is_bookmark": isBookmark,
        "view_count": viewCount,
        "type": type,
        "yes_percent": yesPercent,
        "no_percent": noPercent,
        "author_name": authorName,
        "image": image,
        "category_name": categoryName,
        "color": color,
        "create_date": createDate,
        "blog_category": blogCategory == null
            ? []
            : List<dynamic>.from(blogCategory!.map((x) => x.toJson())),
        "frequency": frequency,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "view": view,
        "click": click,
        "click_count": clickCount,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class BlogDatum {
  int? currentPage;
  List<Blog>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  BlogDatum({
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

  factory BlogDatum.fromJson(Map<String, dynamic> json) => BlogDatum(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Blog>.from(json["data"]!.map((x) => Blog.fromJson(x))),
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
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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

class CategoryElement {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? color;
  int? order;
  int? status;
  int? isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  BlogDatum? blog;
  bool? isMyFeed;
  int? index;

  CategoryElement({
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
    this.blog,
    this.isMyFeed,
    this.index,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        color: json["color"],
        order: json["order"],
        status: json["status"],
        isFeatured: json["is_featured"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        blog: json["blog"] == null ? null : BlogDatum.fromJson(json["blog"]),
        isMyFeed: json["isMyFeed"],
        index: json["index"],
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "blog": blog?.toJson(),
        "isMyFeed": isMyFeed,
        "index": index,
      };
}

class Media {
  int? id;
  int? adId;
  String? type;
  String? file;
  dynamic youtubeUrl;
  String? redirectedUrl;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Media({
    this.id,
    this.adId,
    this.type,
    this.file,
    this.youtubeUrl,
    this.redirectedUrl,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        adId: json["ad_id"],
        type: json["type"],
        file: json["file"],
        youtubeUrl: json["youtube_url"],
        redirectedUrl: json["redirected_url"],
        position: json["position"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ad_id": adId,
        "type": type,
        "file": file,
        "youtube_url": youtubeUrl,
        "redirected_url": redirectedUrl,
        "position": position,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class FilteredBlog {
  FilteredBlog({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Blog>? data;

  factory FilteredBlog.fromJson(Map<String, dynamic> json) => FilteredBlog(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Blog>.from(json["data"]!.map((x) => Blog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyFeed {
  bool? status;
  String? message;
  BlogDatum? data;

  MyFeed({
    this.status,
    this.message,
    this.data,
  });

  factory MyFeed.fromJson(Map<String, dynamic> json) => MyFeed(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : BlogDatum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}
