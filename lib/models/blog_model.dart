//@dart=2.9

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:incite/models/blog_category.dart';

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
