import 'dart:convert';
import 'dart:io';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/app/routes.dart';
import 'package:eClassify/data/cubits/custom_field/fetch_custom_fields_cubit.dart';
import 'package:eClassify/data/model/custom_field/custom_field_model.dart';
import 'package:eClassify/data/model/item/item_model.dart';
import 'package:eClassify/ui/screens/item/add_item_screen/custom_filed_structure/custom_field.dart';
import 'package:eClassify/ui/screens/item/add_item_screen/select_category.dart';

import 'package:eClassify/ui/screens/widgets/dynamic_field.dart';
import 'package:eClassify/utils/cloud_state/cloud_state.dart';
import 'package:eClassify/utils/custom_text.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMoreDetailsScreen extends StatefulWidget {
  final bool? isEdit;
  final File? mainImage;

  final List<File>? otherImage;

  const AddMoreDetailsScreen(
      {super.key, this.isEdit, this.mainImage, this.otherImage});

  static MaterialPageRoute route(RouteSettings settings) {
    Map? args = settings.arguments as Map?;
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider.value(
          value:
              (args?['context'] as BuildContext).read<FetchCustomFieldsCubit>(),
          child: AddMoreDetailsScreen(
            isEdit: args?['isEdit'],
            mainImage: args?['mainImage'],
            otherImage: args?['otherImage'],
          ),
        );
      },
    );
  }

  @override
  CloudState<AddMoreDetailsScreen> createState() =>
      _AddMoreDetailsScreenState();
}

class _AddMoreDetailsScreenState extends CloudState<AddMoreDetailsScreen> {
  List<CustomFieldBuilder> moreDetailDynamicFields = [];
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    Future.delayed(
      Duration.zero,
      () {
        moreDetailDynamicFields =
            context.read<FetchCustomFieldsCubit>().getFields().map((field) {
          Map<String, dynamic> fieldData = field.toMap();
          // Assuming 'getCloudData' returns the correct item based on 'edit_request'

          // Check if 'item' and 'item.customFields' are not null before accessing them
          if (widget.isEdit == true) {
            ItemModel item = getCloudData('edit_request') as ItemModel;

            CustomFieldModel? matchingField =
                item.customFields!.any((e) => e.id == field.id)
                    ? item.customFields?.firstWhere((e) => e.id == field.id)
                    : null;
            if (matchingField != null) {
              // Set 'value' in 'fieldData' based on the matching field's value
              fieldData['value'] = matchingField.value;
            } // Use null-aware operator '?.' for safety
          }

          fieldData['isEdit'] = widget.isEdit == true;
          CustomFieldBuilder customFieldBuilder = CustomFieldBuilder(fieldData);
          customFieldBuilder.stateUpdater(setState);
          customFieldBuilder.init();
          return customFieldBuilder;
        }).toList();

        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.color.mainColor,
        appBar: UiUtils.buildAppBar(context,
            showBackButton: true, title: "AdDetails".translate(context)),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: UiUtils.buildButton(
              context,
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Map itemDetailsScreenData = getCloudData("item_details");
                  itemDetailsScreenData['custom_fields'] =
                      json.encode(AbstractField.fieldsData);

                  itemDetailsScreenData.addAll(AbstractField.files);

                  addCloudData("with_more_details", itemDetailsScreenData);
                  // itemDetailsScreenData
                  screenStack++;
                  Navigator.pushNamed(
                    context,
                    Routes.confirmLocationScreen,
                    arguments: {
                      "isEdit": widget.isEdit == true,
                      "mainImage": widget.mainImage,
                      "otherImage": widget.otherImage
                    },
                  ).then((value) {
                    screenStack--;

                    if (value == "success") {
                      screenStack = 0;
                    }
                  });
                }
              },
              height: 48,
              fontSize: context.font.large,
              buttonTitle: "next".translate(context),
            ),
          ),
        ),
        body: BlocConsumer<FetchCustomFieldsCubit, FetchCustomFieldState>(
          listener: (context, state) {
            if (state is FetchCustomFieldSuccess) {
              if (state.fields.isEmpty) {
                Navigator.pushNamed(context, Routes.confirmLocationScreen,
                    arguments: {
                      "mainImage": widget.mainImage,
                      "otherImage": widget.otherImage,
                      "isEdit": widget.isEdit,
                    }).then((value) {
                  screenStack--;

                  if (value == "success") {
                    screenStack = 0;
                  }
                });
              }
            }
          },
          builder: (context, state) {
            if (state is FetchCustomFieldFail) {
              return Center(
                child: CustomText(state.error.toString()),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderCard(context),
                      const SizedBox(height: 16),
                      _sectionCard(
                        context,
                        title: "giveMoreDetailsAboutYourAds".translate(context),
                        icon: Icons.tune_outlined,
                        child: Column(
                          children: moreDetailDynamicFields.map(
                            (field) {
                              field.stateUpdater(setState);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9.0),
                                child: field.build(context),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.color.mainBrown,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: context.color.mainGold.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.color.mainGold.withValues(alpha: 0.6),
              ),
            ),
            child: Icon(
              Icons.playlist_add_check_outlined,
              color: context.color.mainGold,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "giveMoreDetailsAboutYourAds".translate(context),
                  fontSize: context.font.large,
                  fontWeight: FontWeight.w600,
                  color: context.color.secondaryColor,
                ),
                const SizedBox(height: 6),
                CustomText(
                  "AdDetails".translate(context),
                  fontSize: context.font.normal,
                  color: context.color.secondaryColor.withValues(alpha: 0.75),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    String? subtitle,
    IconData? icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.color.secondaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.color.textLightColor.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: context.color.mainGold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: context.color.mainBrown,
                  ),
                ),
              if (icon != null) const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title,
                      fontSize: context.font.large,
                      fontWeight: FontWeight.w600,
                      color: context.color.textColorDark,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      CustomText(
                        subtitle,
                        fontSize: context.font.small,
                        color:
                            context.color.textLightColor.withValues(alpha: 0.7),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
