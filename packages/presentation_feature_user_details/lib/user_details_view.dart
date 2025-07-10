import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/layout/safe_scaffold.dart';
import 'package:presentation_core_ui/layout/scrollable_column.dart';
import 'package:presentation_core_ui/miscellaneous/formatter/formatter_phone.dart';
import 'package:presentation_core_ui/widget/button/icon/action_button.dart';
import 'package:presentation_core_ui/widget/button/primary/primary_button.dart';
import 'package:presentation_core_ui/widget/field/datetime_field.dart';
import 'package:presentation_core_ui/widget/field/simple_field.dart';
import 'package:presentation_core_ui/widget/field/operator/operator_field.dart';
import 'package:presentation_core_ui/widget/field/operator/operator_value.dart';
import 'package:presentation_core_ui/widget/footer/simple_footer.dart';
import 'package:presentation_core_ui/widget/header/header_divider_controller.dart';
import 'package:presentation_core_ui/widget/header/simple_header.dart';
import 'package:presentation_feature_main/core/navigation/home_navigation.dart';
import 'package:presentation_feature_main/home_page.dart';
import 'package:presentation_feature_welcome/dialog/welcome_dialog.dart';

import 'bloc/user_details_bloc.dart';
import 'bloc/user_details_event.dart';
import 'bloc/user_details_state.dart';
import 'core/widget/state/error_state.dart';
import 'core/widget/state/loading_state.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final HeaderDividerController headerDividerController =
      HeaderDividerController();
  final SimpleFooterController simpleFooterController =
      SimpleFooterController();

  String firstName = "";
  String lastName = "";
  String email = "";
  String operator = "";
  String phone = "";
  int? dateOfBirth = null;

  @override
  void initState() {
    super.initState();

    context.read<UserDetailsBloc>().add(UserDetailsLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeScaffold(
      appBar: SimpleHeader(
          title: null,
          onPressed: () {
            Navigator.of(context).pop();
          },
          headerDividerController: headerDividerController),
      body: _buildView(context),
    );
  }

  Widget _buildView(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocListener<UserDetailsBloc, UserDetailsState>(
        listener: (context, state) {
          if (state is UserDetailsValidationErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: colorScheme.errorN200,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                showCloseIcon: true,
                closeIconColor: colorScheme.neutralN900,
                content: Text(
                  context.tr(state.errorMessage),
                  style: textTheme.bodyMedium02
                      .copyWith(color: colorScheme.errorN900),
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16),
              ),
            );
          }
          if (state is UserDetailsDoneState) {
            MarketRoute().go(context);
          }
        },
        child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          bloc: context.read<UserDetailsBloc>(),
          builder: (context, state) {
            switch (state) {
              case UserDetailsInitialState():
                return LoadingState();
              case UserDetailsLoadingState():
                return LoadingState();
              case UserDetailsErrorState():
                return ErrorState(onClick: null);
              default:
                return _buildContent(context, state);
            }
          },
        ));
  }

  Widget _buildContent(BuildContext context, data) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
        child: ScrollableColumn(
          onOverScroll: (isOverScroll) {
            headerDividerController.setVisibility(isOverScroll);
            simpleFooterController.setVisibility(!isOverScroll);
          },
          children: [
            Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("userDetailsTitle"),
                      style: textTheme.titleHighlight01.copyWith(
                        color: colorScheme.neutralN900,
                      ),
                      textAlign: TextAlign.left,
                    ))),
            Padding(
                padding: EdgeInsets.only(top: 8, left: 16, right: 16),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("userDetailsDetails"),
                      style: textTheme.body02.copyWith(
                        color: colorScheme.neutralN900,
                      ),
                      textAlign: TextAlign.left,
                    ))),
            Padding(
                padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                child: SimpleField(
                  label: tr("generalFirstName"),
                  regexPattern: r'^[a-zA-Zа-яА-ЯёЁіІїЇєЄґҐ\s]+$',
                  onChanged: (value) {
                    firstName = value;
                  },
                )),
            Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: SimpleField(
                  label: tr("generalLastName"),
                  regexPattern: r'^[a-zA-Zа-яА-ЯёЁіІїЇєЄґҐ\s]+$',
                  onChanged: (value) {
                    lastName = value;
                  },
                )),
            Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: SimpleField(
                  label: tr("generalEmail"),
                  regexPattern: r'^[a-zA-Z0-9._%+-@]*$',
                  onChanged: (value) {
                    email = value;
                  },
                )),
            Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(children: [
                  Flexible(
                    flex: 1,
                    child: OperatorField(
                      operators: [
                        OperatorValue(
                          label: "+380",
                          icon: 'assets/icon/icon-ua-flag-24.svg',
                        ),
                      ],
                      hint: tr("generalOperatorArea"),
                      onSaved: (value) {
                        // setState(() {
                        operator = value ?? "";
                        // });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 2,
                    child: SimpleField(
                      label: tr("generalPhone"),
                      inputFormatters: PhoneFormatter(),
                      length: 14,
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                    ),
                  ),
                ])),
            Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: DateTimeField(
                  label: (dateOfBirth != null)
                      ? DateFormat('dd/MM/yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(dateOfBirth ?? 0))
                      : tr("generalDateOfBirth"),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          dateOfBirth = value.millisecondsSinceEpoch;
                        });
                      }
                    });
                  },
                )),
          ],
        ),
      ),
      SimpleFooter(
          simpleFooterController: simpleFooterController,
          content: PrimaryButton(
            onClick: () {
              context.read<UserDetailsBloc>().add(UserDetailsSaveEvent(
                  firstName,
                  lastName,
                  email,
                  operator,
                  phone,
                  dateOfBirth ?? 0));
            },
            title: tr("generalContinue"),
          ))
    ]);
  }
}
