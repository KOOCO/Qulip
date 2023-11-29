import 'dart:convert';

SettingsModel settingsModelFromJson(String str) =>
    SettingsModel.fromJson(json.decode(str));
String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  SettingsModel({
    this.supportEmail,
    this.supportContact,
    this.dateFormatMobile,
    this.languages,
    this.appVersion,
    this.country,
    this.currency,
    this.contentPages,
  });

  SettingsModel.fromJson(Map<String, dynamic> json) {
    supportEmail = json['support_email'];
    supportContact = json['support_contact'];
    dateFormatMobile = json['date_format_mobile'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    if (json['app_version'] != null) {
      appVersion = <AppVersion>[];
      json['app_version'].forEach((v) {
        appVersion!.add(AppVersion.fromJson(v));
      });
    }
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
    if (json['currency'] != null) {
      currency = <Currency>[];
      json['currency'].forEach((v) {
        currency!.add(Currency.fromJson(v));
      });
    }
    if (json['content_pages'] != null) {
      contentPages = <ContentPages>[];
      json['content_pages'].forEach((v) {
        contentPages!.add(ContentPages.fromJson(v));
      });
    }
  }
  String? supportEmail;
  String? supportContact;
  String? dateFormatMobile;
  List<Languages>? languages;
  List<AppVersion>? appVersion;
  List<Country>? country;
  List<Currency>? currency;
  List<ContentPages>? contentPages;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['support_email'] = supportEmail;
    data['support_contact'] = supportContact;
    data['date_format_mobile'] = dateFormatMobile;
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    if (appVersion != null) {
      data['app_version'] = appVersion!.map((v) => v.toJson()).toList();
    }
    if (country != null) {
      data['country'] = country!.map((v) => v.toJson()).toList();
    }
    if (currency != null) {
      data['currency'] = currency!.map((v) => v.toJson()).toList();
    }
    if (contentPages != null) {
      data['content_pages'] = contentPages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Languages {
  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    isDefault = json['is_default'];
    flag = json['flag'];
  }

  Languages({this.id, this.name, this.code, this.isDefault, this.flag});
  int? id;
  String? name;
  String? code;
  int? isDefault;
  String? flag;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['is_default'] = isDefault;
    data['flag'] = flag;
    return data;
  }
}

class AppVersion {
  AppVersion({
    this.id,
    this.versionCode,
    this.buildNo,
    this.requiredUpdate,
    this.appVersionLang,
  });

  AppVersion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    versionCode = json['version_code'];
    buildNo = json['build_no'];
    requiredUpdate = json['required_update'];
    if (json['app_version_lang'] != null) {
      appVersionLang = <AppVersionLang>[];
      json['app_version_lang'].forEach((v) {
        appVersionLang!.add(AppVersionLang.fromJson(v));
      });
    }
  }
  int? id;
  String? versionCode;
  int? buildNo;
  int? requiredUpdate;
  List<AppVersionLang>? appVersionLang;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version_code'] = versionCode;
    data['build_no'] = buildNo;
    data['required_update'] = requiredUpdate;
    if (appVersionLang != null) {
      data['app_version_lang'] =
          appVersionLang!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppVersionLang {
  AppVersionLang({
    this.appVersionId,
    this.langId,
    this.versionTitle,
    this.versionDesc,
  });

  AppVersionLang.fromJson(Map<String, dynamic> json) {
    appVersionId = json['app_version_id'];
    langId = json['lang_id'];
    versionTitle = json['version_title'];
    versionDesc = json['version_desc'];
  }
  int? appVersionId;
  int? langId;
  String? versionTitle;
  String? versionDesc;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_version_id'] = appVersionId;
    data['lang_id'] = langId;
    data['version_title'] = versionTitle;
    data['version_desc'] = versionDesc;
    return data;
  }
}

class Country {
  Country({
    this.id,
    this.name,
    this.code,
    this.mobileCode,
    this.flag,
    this.sbVendorId,
    this.sbOutletId,
    this.sbReferPoint,
  });

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    mobileCode = json['mobile_code'];
    flag = json['flag'];
    sbVendorId = json['sb_vendor_id'];
    sbOutletId = json['sb_outlet_id'];
    sbReferPoint = json['sb_refer_point'];
  }
  int? id;
  String? name;
  String? code;
  int? mobileCode;
  String? flag;
  int? sbVendorId;
  int? sbOutletId;
  String? sbReferPoint;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['mobile_code'] = mobileCode;
    data['flag'] = flag;
    data['sb_vendor_id'] = sbVendorId;
    data['sb_outlet_id'] = sbOutletId;
    data['sb_refer_point'] = sbReferPoint;
    return data;
  }
}

class Currency {
  Currency({
    this.id,
    this.name,
    this.countryId,
    this.code,
    this.isDefault,
    this.value,
    this.icon,
    this.symbol,
  });

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    code = json['code'];
    isDefault = json['is_default'];
    value = json['value'];
    icon = json['icon'];
    symbol = json['symbol'];
  }
  int? id;
  String? name;
  int? countryId;
  String? code;
  int? isDefault;
  String? value;
  String? icon;
  String? symbol;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    data['code'] = code;
    data['is_default'] = isDefault;
    data['value'] = value;
    data['icon'] = icon;
    data['symbol'] = symbol;
    return data;
  }
}

class ContentPages {
  ContentPages.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
  }

  ContentPages({this.url, this.title});
  String? url;
  String? title;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['title'] = title;
    return data;
  }
}
