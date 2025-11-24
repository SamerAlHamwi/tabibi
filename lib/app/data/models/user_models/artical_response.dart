class ArticleResponse {
  bool? success;
  String? message;
  Data? data;

  ArticleResponse({this.success, this.message, this.data});

  ArticleResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Article>? article;
  Pagination? pagination;

  Data({this.article, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['article'] != null) {
      article = <Article>[];
      json['article'].forEach((v) {
        article!.add(Article.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (article != null) {
      data['article'] = article!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Article {
  int? id;
  String? titleEn;
  String? titleAr;
  String? bodyEn;
  String? bodyAr;
  String? author;
  String? photo;
  String? createdAt;
  String? updatedAt;

  Article(
      {this.id,
        this.titleEn,
        this.titleAr,
        this.bodyEn,
        this.bodyAr,
        this.author,
        this.photo,
        this.createdAt,
        this.updatedAt});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleEn = json['title_en'];
    titleAr = json['title_ar'];
    bodyEn = json['body_en'];
    bodyAr = json['body_ar'];
    author = json['author'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title_en'] = titleEn;
    data['title_ar'] = titleAr;
    data['body_en'] = bodyEn;
    data['body_ar'] = bodyAr;
    data['author'] = author;
    data['photo'] = photo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Pagination {
  int? currentPage;
  bool? hasNext;
  bool? hasPrevious;
  int? perPage;
  int? total;
  int? lastPage;

  Pagination(
      {this.currentPage,
        this.hasNext,
        this.hasPrevious,
        this.perPage,
        this.total,
        this.lastPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
    perPage = json['per_page'];
    total = json['total'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['has_next'] = hasNext;
    data['has_previous'] = hasPrevious;
    data['per_page'] = perPage;
    data['total'] = total;
    data['last_page'] = lastPage;
    return data;
  }
}
