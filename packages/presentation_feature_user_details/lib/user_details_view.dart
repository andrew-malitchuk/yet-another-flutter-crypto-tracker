import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/layout/safe_scaffold.dart';
import 'package:presentation_core_ui/layout/scrollable_column.dart';
import 'package:presentation_core_ui/miscellaneous/formatter/formatter_phone.dart';
import 'package:presentation_core_ui/widget/button/primary/primary_button.dart';
import 'package:presentation_core_ui/widget/field/datetime_field.dart';
import 'package:presentation_core_ui/widget/field/simple_field.dart';
import 'package:presentation_core_ui/widget/field/operator/operator_field.dart';
import 'package:presentation_core_ui/widget/field/operator/operator_value.dart';
import 'package:presentation_core_ui/widget/footer/simple_footer.dart';
import 'package:presentation_core_ui/widget/header/header_divider_controller.dart';
import 'package:presentation_core_ui/widget/header/simple_header.dart';
import 'package:presentation_feature_main/core/navigation/home_navigation.dart';

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

  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String operatorCode = "";
  int? dateOfBirth;

  bool _seededFromBloc = false;

  @override
  void initState() {
    super.initState();
    context.read<UserDetailsBloc>().add(UserDetailsLoadEvent());
  }

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: SimpleHeader(
        title: null,
        onPressed: () => Navigator.of(context).pop(),
        headerDividerController: headerDividerController,
      ),
      body: BlocListener<UserDetailsBloc, UserDetailsState>(
        listener: (context, state) {
          if (state is UserDetailsValidationErrorState) {}
          if (state is UserDetailsDoneState) {
            MarketRoute().go(context);
          }
          if (state is UserDetailsLoadedState && !_seededFromBloc) {
            _seededFromBloc = true;
            final p = state.userProfile;
            firstNameController.text = p?.firstName ?? "";
            secondNameController.text = p?.secondName ?? "";
            emailController.text = p?.email ?? "";
            phoneController.text = p?.phone.replaceAll("+380", "") ?? "";
          }
        },
        child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (context, state) {
            switch (state) {
              case UserDetailsInitialState():
              case UserDetailsLoadingState():
                return LoadingState();
              case UserDetailsLoadedState():
                return _buildContent(context);
              default:
                return ErrorState(onClick: null);
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      children: [
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
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: SimpleField(
                  controller: firstNameController,
                  label: tr("generalFirstName"),
                  regexPattern: r'^[a-zA-Zа-яА-ЯёЁіІїЇєЄґҐ\s]+$',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: SimpleField(
                  controller: secondNameController,
                  label: tr("generalLastName"),
                  regexPattern: r'^[a-zA-Zа-яА-ЯёЁіІїЇєЄґҐ\s]+$',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: SimpleField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  label: tr("generalEmail"),
                  regexPattern: r'^[a-zA-Z0-9._%+-@]*$',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  children: [
                    Flexible(
                      child: OperatorField(
                        operators: [
                          OperatorValue(
                              label: "+380",
                              icon: 'assets/icon/icon-ua-flag-24.svg')
                        ],
                        hint: tr("generalOperatorArea"),
                        onSaved: (value) {
                          setState(() {
                            operatorCode = value ?? "";
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      flex: 2,
                      child: SimpleField(
                        controller: phoneController,
                        label: tr("generalPhone"),
                        inputFormatters: PhoneFormatter(),
                        keyboardType: TextInputType.number,
                        length: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: DateTimeField(
                  label: (dateOfBirth != null)
                      ? DateFormat('dd/MM/yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(dateOfBirth!))
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
                ),
              ),
            ],
          ),
        ),
        SimpleFooter(
          simpleFooterController: simpleFooterController,
          content: PrimaryButton(
            onClick: () {
              context.read<UserDetailsBloc>().add(
                    UserDetailsSaveEvent(
                      firstNameController.text,
                      secondNameController.text,
                      emailController.text,
                      operatorCode,
                      phoneController.text,
                      dateOfBirth ?? 0,
                    ),
                  );
            },
            title: tr("generalContinue"),
          ),
        ),
      ],
    );
  }
}
