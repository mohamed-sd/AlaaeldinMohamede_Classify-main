import 'dart:io';

import 'package:eClassify/ui/screens/widgets/custom_text_form_field.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/custom_text.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/helper_utils.dart';
import 'package:eClassify/utils/image_picker.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// صفحة إكمال الملف الشخصي الشامل
/// تدعم نوعين من الحسابات: فرد Individual و شركة Company
class ComprehensiveProfileScreen extends StatefulWidget {
  const ComprehensiveProfileScreen({super.key});

  @override
  State<ComprehensiveProfileScreen> createState() =>
      _ComprehensiveProfileScreenState();

  static Route route(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (_) => const ComprehensiveProfileScreen(),
    );
  }
}

class _ComprehensiveProfileScreenState
    extends State<ComprehensiveProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // نوع الحساب: individual أو company
  String accountType = 'individual';

  // ========== حقول مشتركة ==========
  File? profileImage;
  File? coverImage;
  final TextEditingController bioController = TextEditingController();

  // ========== حقول خاصة بالفرد ==========
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController yearsOfExperienceController =
      TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController previousExperienceController =
      TextEditingController();
  final TextEditingController certificatesController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController languagesController = TextEditingController();
  File? cvFile;
  List<File> portfolioImages = [];

  // ========== حقول خاصة بالشركة ==========
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController businessFieldController = TextEditingController();
  final TextEditingController companyBioController = TextEditingController();
  final TextEditingController employeeCountController = TextEditingController();
  final TextEditingController foundingYearController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController achievementsController = TextEditingController();
  final TextEditingController commercialRegisterController =
      TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  File? companyLogo;
  File? companyBanner;
  List<File> companyImages = [];

  // ========== إعدادات الخصوصية ==========
  bool showProfileToPublic = true;
  bool allowMessagesFromStrangers = true;
  bool showCV = true;
  bool showPersonalInfo = true;
  bool allowProfileSharing = true;

  // ========== Image Pickers ==========
  final PickImage profileImagePicker = PickImage();
  final PickImage cvPicker = PickImage();
  final PickImage portfolioPicker = PickImage();
  final PickImage companyLogoPicker = PickImage();
  final PickImage companyBannerPicker = PickImage();
  final PickImage companyImagesPicker = PickImage();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // تهيئة Image Pickers
    profileImagePicker.listener((files) {
      if (files != null && files.isNotEmpty) {
        setState(() {
          profileImage = files.first;
        });
      }
    });

    cvPicker.listener((files) {
      if (files != null && files.isNotEmpty) {
        setState(() {
          cvFile = files.first;
        });
      }
    });

    portfolioPicker.listener((files) {
      if (files != null && files.isNotEmpty) {
        setState(() {
          portfolioImages = files.take(5).toList();
        });
      }
    });

    companyLogoPicker.listener((files) {
      if (files != null && files.isNotEmpty) {
        setState(() {
          companyLogo = files.first;
        });
      }
    });

    companyBannerPicker.listener((files) {
      if (files != null && files.isNotEmpty) {
        setState(() {
          companyBanner = files.first;
        });
      }
    });

    companyImagesPicker.listener((files) {
      if (files != null && files.isNotEmpty) {
        setState(() {
          companyImages = files.take(10).toList();
        });
      }
    });
  }

  @override
  void dispose() {
    // التخلص من Controllers
    bioController.dispose();
    jobTitleController.dispose();
    specializationController.dispose();
    yearsOfExperienceController.dispose();
    educationController.dispose();
    previousExperienceController.dispose();
    certificatesController.dispose();
    skillsController.dispose();
    languagesController.dispose();
    companyNameController.dispose();
    businessFieldController.dispose();
    companyBioController.dispose();
    employeeCountController.dispose();
    foundingYearController.dispose();
    websiteController.dispose();
    achievementsController.dispose();
    commercialRegisterController.dispose();
    licenseController.dispose();

    // التخلص من Image Pickers
    profileImagePicker.dispose();
    cvPicker.dispose();
    portfolioPicker.dispose();
    companyLogoPicker.dispose();
    companyBannerPicker.dispose();
    companyImagesPicker.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.color.primaryColor,
        appBar: UiUtils.buildAppBar(
          context,
          showBackButton: true,
          title: "إكمال الملف الشخصي الشامل",
        ),
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اختيار نوع الحساب
                    _buildAccountTypeSelector(),
                    const SizedBox(height: 30),

                    // عرض الحقول حسب نوع الحساب
                    if (accountType == 'individual')
                      _buildIndividualProfile()
                    else
                      _buildCompanyProfile(),

                    const SizedBox(height: 30),

                    // زر الحفظ
                    _buildSaveButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Center(
                child: UiUtils.progress(
                  normalProgressColor: context.color.mainGold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// بناء محدد نوع الحساب
  Widget _buildAccountTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          "نوع الحساب",
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _buildAccountTypeCard(
                type: 'individual',
                title: 'فرد',
                subtitle: 'حساب شخصي',
                icon: Icons.person,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildAccountTypeCard(
                type: 'company',
                title: 'شركة',
                subtitle: 'حساب تجاري',
                icon: Icons.business,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// بناء بطاقة نوع الحساب
  Widget _buildAccountTypeCard({
    required String type,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = accountType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          accountType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? context.color.mainGold.withOpacity(0.1)
              : context.color.secondaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? context.color.mainGold : context.color.borderColor,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected
                  ? context.color.mainGold
                  : context.color.textDefaultColor.withOpacity(0.5),
            ),
            const SizedBox(height: 10),
            CustomText(
              title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? context.color.mainGold
                  : context.color.textDefaultColor,
            ),
            const SizedBox(height: 5),
            CustomText(
              subtitle,
              fontSize: 12,
              color: context.color.textDefaultColor.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  /// بناء ملف الفرد
  Widget _buildIndividualProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // القسم 1: البيانات الشخصية الأساسية
        _buildSectionTitle("القسم 1 - البيانات الشخصية الأساسية"),
        const SizedBox(height: 15),

        // الصورة الشخصية
        _buildImagePicker(
          label: "الصورة الشخصية",
          currentImage: profileImage,
          onTap: () => profileImagePicker.pick(context: context),
        ),

        // المسمى الوظيفي
        _buildTextField(
          controller: jobTitleController,
          label: "المسمى الوظيفي الحالي",
          hint: "مثال: مطور تطبيقات",
          isOptional: true,
        ),

        // مجال التخصص
        _buildTextField(
          controller: specializationController,
          label: "مجال التخصص",
          hint: "مثال: تطوير تطبيقات الجوال",
          isOptional: true,
        ),

        // سنوات الخبرة
        _buildTextField(
          controller: yearsOfExperienceController,
          label: "سنوات الخبرة",
          hint: "مثال: 5 سنوات",
          keyboardType: TextInputType.number,
          isOptional: true,
        ),

        const SizedBox(height: 30),

        // القسم 2: النبذة التعريفية
        _buildSectionTitle("القسم 2 - النبذة التعريفية"),
        const SizedBox(height: 15),

        _buildTextField(
          controller: bioController,
          label: "نبذة تعريفية عنك",
          hint: "اكتب نبذة مختصرة عن نفسك (حد أقصى 500 حرف)",
          maxLines: 5,
          maxLength: 500,
          isOptional: true,
        ),

        const SizedBox(height: 30),

        // القسم 3: المستندات والملفات
        _buildSectionTitle("القسم 3 - المستندات والملفات"),
        const SizedBox(height: 15),

        // السيرة الذاتية
        _buildFilePicker(
          label: "السيرة الذاتية (CV)",
          currentFile: cvFile,
          onTap: () => cvPicker.pick(
            context: context,
            pickMultiple: false,
          ),
          allowedFormats: "PDF, DOC (حد أقصى 5MB)",
        ),

        const SizedBox(height: 15),

        // صور إضافية (Portfolio)
        _buildMultipleImagesPicker(
          label: "صور إضافية (Portfolio)",
          images: portfolioImages,
          onTap: () => portfolioPicker.pick(
            context: context,
            pickMultiple: true,
          ),
          maxImages: 5,
        ),

        const SizedBox(height: 30),

        // القسم 4: المعلومات المهنية
        _buildSectionTitle("القسم 4 - المعلومات المهنية"),
        const SizedBox(height: 15),

        _buildTextField(
          controller: educationController,
          label: "المؤهلات التعليمية",
          hint: "مثال: بكالوريوس هندسة برمجيات",
          maxLines: 3,
          isOptional: true,
        ),

        _buildTextField(
          controller: previousExperienceController,
          label: "الخبرات السابقة",
          hint: "اذكر خبراتك السابقة",
          maxLines: 4,
          isOptional: true,
        ),

        _buildTextField(
          controller: certificatesController,
          label: "الشهادات والدورات",
          hint: "اذكر الشهادات والدورات التدريبية",
          maxLines: 3,
          isOptional: true,
        ),

        _buildTextField(
          controller: skillsController,
          label: "المهارات والتخصصات",
          hint: "مثال: Flutter, Dart, Firebase",
          maxLines: 3,
          isOptional: true,
        ),

        _buildTextField(
          controller: languagesController,
          label: "اللغات",
          hint: "مثال: العربية (ممتاز)، الإنجليزية (جيد)",
          maxLines: 2,
          isOptional: true,
        ),

        const SizedBox(height: 30),

        // القسم 5: تفضيلات الظهور والخصوصية
        _buildSectionTitle("القسم 5 - تفضيلات الظهور والخصوصية"),
        const SizedBox(height: 15),

        _buildPrivacySettings(),
      ],
    );
  }

  /// بناء ملف الشركة
  Widget _buildCompanyProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // القسم 1: بيانات الشركة الأساسية
        _buildSectionTitle("القسم 1 - بيانات الشركة الأساسية"),
        const SizedBox(height: 15),

        // شعار الشركة
        _buildImagePicker(
          label: "شعار الشركة (Logo)",
          currentImage: companyLogo,
          onTap: () => companyLogoPicker.pick(context: context),
        ),

        // صورة الغلاف
        _buildImagePicker(
          label: "صورة الغلاف (Banner)",
          currentImage: companyBanner,
          onTap: () => companyBannerPicker.pick(context: context),
          isWide: true,
        ),

        // اسم الشركة
        _buildTextField(
          controller: companyNameController,
          label: "اسم الشركة الرسمي",
          hint: "مثال: شركة التقنية المتقدمة",
        ),

        // مجال النشاط
        _buildTextField(
          controller: businessFieldController,
          label: "مجال النشاط / التخصص",
          hint: "مثال: تطوير البرمجيات",
        ),

        const SizedBox(height: 30),

        // القسم 2: النبذة التعريفية
        _buildSectionTitle("القسم 2 - النبذة التعريفية عن الشركة"),
        const SizedBox(height: 15),

        _buildTextField(
          controller: companyBioController,
          label: "نبذة تعريفية عن الشركة",
          hint: "اكتب نبذة مختصرة عن الشركة (حد أقصى 1000 حرف)",
          maxLines: 6,
          maxLength: 1000,
          isOptional: true,
        ),

        const SizedBox(height: 30),

        // القسم 3: المستندات والملفات
        _buildSectionTitle("القسم 3 - المستندات والملفات"),
        const SizedBox(height: 15),

        // صور العاملين / الأنشطة
        _buildMultipleImagesPicker(
          label: "صور العاملين / الأنشطة",
          images: companyImages,
          onTap: () => companyImagesPicker.pick(
            context: context,
            pickMultiple: true,
          ),
          maxImages: 10,
        ),

        const SizedBox(height: 15),

        _buildTextField(
          controller: commercialRegisterController,
          label: "السجل التجاري (اختياري)",
          hint: "رقم السجل التجاري",
          isOptional: true,
        ),

        _buildTextField(
          controller: licenseController,
          label: "الترخيص (اختياري)",
          hint: "رقم الترخيص",
          isOptional: true,
        ),

        const SizedBox(height: 30),

        // القسم 4: معلومات الشركة المتقدمة
        _buildSectionTitle("القسم 4 - معلومات الشركة المتقدمة"),
        const SizedBox(height: 15),

        _buildTextField(
          controller: employeeCountController,
          label: "عدد الموظفين",
          hint: "مثال: 50-100",
          keyboardType: TextInputType.number,
          isOptional: true,
        ),

        _buildTextField(
          controller: foundingYearController,
          label: "سنة التأسيس",
          hint: "مثال: 2020",
          keyboardType: TextInputType.number,
          isOptional: true,
        ),

        _buildTextField(
          controller: websiteController,
          label: "الموقع الإلكتروني",
          hint: "مثال: www.example.com",
          keyboardType: TextInputType.url,
          isOptional: true,
        ),

        _buildTextField(
          controller: achievementsController,
          label: "الإنجازات والخبرات",
          hint: "اذكر أبرز إنجازات الشركة",
          maxLines: 4,
          isOptional: true,
        ),

        const SizedBox(height: 30),

        // القسم 5: تفضيلات الظهور والخصوصية
        _buildSectionTitle("القسم 5 - تفضيلات الظهور والخصوصية"),
        const SizedBox(height: 15),

        _buildPrivacySettings(),
      ],
    );
  }

  /// بناء عنوان القسم
  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: context.color.mainBrown.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.label,
            color: context.color.mainBrown,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomText(
              title,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: context.color.mainBrown,
            ),
          ),
        ],
      ),
    );
  }

  /// بناء حقل نصي
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    int maxLines = 1,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    bool isOptional = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            CustomText(
              label,
              fontSize: 14,
            ),
            if (isOptional)
              CustomText(
                " (اختياري)",
                fontSize: 12,
                color: context.color.textDefaultColor.withOpacity(0.5),
              ),
          ],
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: controller,
          hintText: hint,
          maxLine: maxLines,
          maxLength: maxLength,
          keyboard: keyboardType,
        ),
      ],
    );
  }

  /// بناء منتقي صورة واحدة
  Widget _buildImagePicker({
    required String label,
    required File? currentImage,
    required VoidCallback onTap,
    bool isWide = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        CustomText(
          label,
          fontSize: 14,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: isWide ? 120 : 150,
            width: isWide ? double.infinity : 150,
            decoration: BoxDecoration(
              color: context.color.secondaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.color.borderColor,
              ),
            ),
            child: currentImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      currentImage,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: context.color.textDefaultColor.withOpacity(0.3),
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        "اضغط لاختيار صورة",
                        fontSize: 12,
                        color: context.color.textDefaultColor.withOpacity(0.5),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  /// بناء منتقي ملف
  Widget _buildFilePicker({
    required String label,
    required File? currentFile,
    required VoidCallback onTap,
    String? allowedFormats,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        CustomText(
          label,
          fontSize: 14,
        ),
        if (allowedFormats != null)
          CustomText(
            allowedFormats,
            fontSize: 11,
            color: context.color.textDefaultColor.withOpacity(0.5),
          ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: context.color.secondaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.color.borderColor,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  currentFile != null ? Icons.check_circle : Icons.upload_file,
                  color: currentFile != null
                      ? Colors.green
                      : context.color.textDefaultColor.withOpacity(0.5),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    currentFile != null
                        ? currentFile.path.split('/').last
                        : "اضغط لاختيار ملف",
                    fontSize: 13,
                    color: currentFile != null
                        ? context.color.textDefaultColor
                        : context.color.textDefaultColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// بناء منتقي صور متعددة
  Widget _buildMultipleImagesPicker({
    required String label,
    required List<File> images,
    required VoidCallback onTap,
    required int maxImages,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              label,
              fontSize: 14,
            ),
            CustomText(
              "${images.length}/$maxImages",
              fontSize: 12,
              color: context.color.textDefaultColor.withOpacity(0.5),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (images.isEmpty)
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: context.color.secondaryColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.color.borderColor,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 35,
                    color: context.color.textDefaultColor.withOpacity(0.3),
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    "اضغط لاختيار صور (حد أقصى $maxImages)",
                    fontSize: 12,
                    color: context.color.textDefaultColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          )
        else
          Column(
            children: [
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      images.length + (images.length < maxImages ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == images.length) {
                      return GestureDetector(
                        onTap: onTap,
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: context.color.secondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: context.color.borderColor,
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color:
                                context.color.textDefaultColor.withOpacity(0.5),
                          ),
                        ),
                      );
                    }
                    return Container(
                      width: 100,
                      margin: const EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              images[index],
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  images.removeAt(index);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }

  /// بناء إعدادات الخصوصية
  Widget _buildPrivacySettings() {
    return Column(
      children: [
        _buildSwitchTile(
          title: accountType == 'individual'
              ? "إظهار ملفي للجمهور"
              : "إظهار ملف الشركة للجمهور",
          value: showProfileToPublic,
          onChanged: (value) {
            setState(() {
              showProfileToPublic = value;
            });
          },
        ),
        _buildSwitchTile(
          title: accountType == 'individual'
              ? "السماح بالرسائل من الغرباء"
              : "السماح بالرسائل من الأفراد",
          value: allowMessagesFromStrangers,
          onChanged: (value) {
            setState(() {
              allowMessagesFromStrangers = value;
            });
          },
        ),
        if (accountType == 'individual')
          _buildSwitchTile(
            title: "إظهار السيرة الذاتية",
            value: showCV,
            onChanged: (value) {
              setState(() {
                showCV = value;
              });
            },
          ),
        _buildSwitchTile(
          title: accountType == 'individual'
              ? "إظهار البيانات الشخصية"
              : "إظهار معلومات الشركة",
          value: showPersonalInfo,
          onChanged: (value) {
            setState(() {
              showPersonalInfo = value;
            });
          },
        ),
        _buildSwitchTile(
          title: accountType == 'individual'
              ? "السماح بمشاركة ملفي"
              : "السماح بمشاركة ملف الشركة",
          value: allowProfileSharing,
          onChanged: (value) {
            setState(() {
              allowProfileSharing = value;
            });
          },
        ),
      ],
    );
  }

  /// بناء مفتاح تبديل
  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: context.color.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              title,
              fontSize: 13,
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: context.color.mainGold,
          ),
        ],
      ),
    );
  }

  /// بناء زر الحفظ
  Widget _buildSaveButton() {
    return UiUtils.buildButton(
      context,
      onPressed: _saveProfile,
      height: 50,
      buttonTitle: "حفظ وإكمال",
      buttonColor: context.color.mainBrown,
    );
  }

  /// حفظ البيانات
  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // هنا يتم حفظ البيانات
      // يمكن إرسال البيانات إلى API أو حفظها محلياً

      // محاكاة عملية الحفظ
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });

        // عرض رسالة نجاح
        HelperUtils.showSnackBarMessage(
          context,
          "تم حفظ الملف الشخصي بنجاح",
          type: MessageType.success,
        );

        // العودة إلى الصفحة السابقة
        Navigator.pop(context);
      });
    } else {
      HelperUtils.showSnackBarMessage(
        context,
        "يرجى ملء جميع الحقول المطلوبة",
        type: MessageType.error,
      );
    }
  }
}
