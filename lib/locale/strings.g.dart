// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Strings _$StringsFromJson(Map<String, dynamic> json) {
  return Strings(
      title: json['title'] as String,
      login_validation_error: json['login_validation_error'] as String,
      posts_not_found: json['posts_not_found'] as String,
      posts_title: json['posts_title'] as String,
      login_et_user_email: json['login_et_user_email'] as String,
      login_et_user_password: json['login_et_user_password'] as String,
      login_btn_forgot_password: json['login_btn_forgot_password'] as String,
      login_btn_sign_in: json['login_btn_sign_in'] as String,
      post_not_selected: json['post_not_selected'] as String,
      settings_title: json['settings_title'] as String);
}

Map<String, dynamic> _$StringsToJson(Strings instance) => <String, dynamic>{
      'title': instance.title,
      'login_et_user_email': instance.login_et_user_email,
      'login_et_user_password': instance.login_et_user_password,
      'login_btn_forgot_password': instance.login_btn_forgot_password,
      'login_btn_sign_in': instance.login_btn_sign_in,
      'login_validation_error': instance.login_validation_error,
      'posts_title': instance.posts_title,
      'posts_not_found': instance.posts_not_found,
      'post_not_selected': instance.post_not_selected,
      'settings_title': instance.settings_title
    };
