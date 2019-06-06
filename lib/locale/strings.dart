
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'strings.g.dart';

@JsonSerializable()
class Strings {
  const Strings({
    @required this.title,
    @required this.login_validation_error,
    @required this.posts_not_found,
    @required this.posts_title,
    @required this.login_et_user_email,
    @required this.login_et_user_password,
    @required this.login_btn_forgot_password,
    @required this.login_btn_sign_in,
    @required this.post_not_selected,
    @required this.settings_title,
  });
  final String title;
  final String login_et_user_email;
  final String login_et_user_password;
  final String login_btn_forgot_password;
  final String login_btn_sign_in;
  final String login_validation_error;
  final String posts_title;
  final String posts_not_found;
  final String post_not_selected;
  final String settings_title;

    factory Strings.fromJson(Map<String, dynamic> json) => _$StringsFromJson(json);
  Map<String, dynamic> toJson() => _$StringsToJson(this);
}
