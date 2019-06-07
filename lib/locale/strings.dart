import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'strings.g.dart';

@JsonSerializable()
class Strings {
  const Strings({
    @required this.title,
    @required this.login_validation_error,
    @required this.posts_not_found,
    @required this.posts_title,
    @required this.login_hint_user_email,
    @required this.login_hint_user_password,
    @required this.login_button_forgot_password,
    @required this.login_button_sign_in,
    @required this.post_not_selected,
    @required this.settings_title,
    @required this.translations_title,
    @required this.current_language,
    @required this.modify_and_change_languages,
    @required this.language,
    @required this.language_required,
    @required this.new_language,
    @required this.edit_language,
    @required this.notifications_title,
    @required this.notifications_subtitle,
    @required this.theme_title,
    @required this.theme_subtitle,
    @required this.intro_subtitle,
    @required this.intro_title,
     @required this.dark_mode_subtitle,
    @required this.dark_mode_title,
  });

  factory Strings.fromJson(Map<String, dynamic> json) =>
      _$StringsFromJson(json);

  final String current_language;
  final String dark_mode_subtitle;
  final String dark_mode_title;
  final String edit_language;
  final String intro_subtitle;
  final String intro_title;
  final String language;
  final String language_required;
  final String login_button_forgot_password;
  final String login_button_sign_in;
  final String login_hint_user_email;
  final String login_hint_user_password;
  final String login_validation_error;
  final String modify_and_change_languages;
  final String new_language;
  final String notifications_subtitle;
  final String notifications_title;
  final String post_not_selected;
  final String posts_not_found;
  final String posts_title;
  final String settings_title;
  final String theme_subtitle;
  final String theme_title;
  final String translations_title;

  @JsonKey(name: 'app_title')
  final String title;

  Map<String, dynamic> toJson() => _$StringsToJson(this);
}
