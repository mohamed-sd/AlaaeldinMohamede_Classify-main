import 'package:flutter/material.dart';

class AddJobAnnouncementScreen extends StatefulWidget {
  const AddJobAnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AddJobAnnouncementScreen> createState() =>
      _AddJobAnnouncementScreenState();
}

class _AddJobAnnouncementScreenState extends State<AddJobAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Form field controllers - Page 1
  final TextEditingController _addTitleController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _numberOfVacanciesController =
  TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  // Form field controllers - Page 2
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactPhoneController =
  TextEditingController();
  final TextEditingController _contactEmailController =
  TextEditingController();
  final TextEditingController _otherContactController =
  TextEditingController();
  final TextEditingController _additionalNotesController =
  TextEditingController();

  // Dropdown values
  String _section = 'الوظائف الإدارية';
  String _addType = 'عرض(توفير وظيفة)';
  String _jobType = 'دوام كامل';
  String _jobSpecialization = 'إداري';
  String _qualifications = 'الثانوية العامة';
  String _yearsOfExperience = 'بدون خبرة';
  String _workTime = 'صباحية';
  String _salaryType = 'قابل للتفاوض';
  List<String> _skills = [];

  // Colors - matching the brown/gold theme from reference
  final Color _primaryColor = const Color(0xFFF5F5F5);
  final Color _accentColor = const Color(0xFFEBBE25); // Gold
  final Color _brownColor = const Color(0xFF221400); // Brown
  final Color _textColor = const Color(0xFF2B2923);
  final Color _borderColor = const Color(0xFFE0E0E0);

  @override
  void dispose() {
    _addTitleController.dispose();
    _jobTitleController.dispose();
    _numberOfVacanciesController.dispose();
    _experienceController.dispose();
    _salaryController.dispose();
    _contactNameController.dispose();
    _contactPhoneController.dispose();
    _contactEmailController.dispose();
    _otherContactController.dispose();
    _additionalNotesController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String labelText, {String? hintText}) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(
        color: _textColor.withOpacity(0.7),
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      hintStyle: TextStyle(
        color: _textColor.withOpacity(0.4),
        fontSize: 12,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: _borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: _borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: _brownColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: _textColor,
        ),
      ),
    );
  }

  Widget _buildNavigationIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem('معلومات أساسية', Icons.info_outline, 0),
          _buildNavItem('التواصل', Icons.contact_phone_outlined, 1),
          _buildNavItem('الملفات', Icons.folder_outlined, 2),
          _buildNavItem('نشر الإعلان', Icons.check_circle_outline, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, IconData icon, int page) {
    final isActive = _currentPage == page;
    final isCompleted = _currentPage > page;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive
                  ? _brownColor
                  : isCompleted
                  ? _accentColor
                  : _borderColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive || isCompleted ? Colors.white : _textColor,
              size: 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? _brownColor : _textColor.withOpacity(0.6),
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('اسم الاعلان'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _addTitleController,
              decoration: _buildInputDecoration('عنوان الإعلان'),
              style: TextStyle(fontSize: 12, color: _textColor),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال عنوان الإعلان';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('قسم الاعلان'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: _section,
              decoration: _buildInputDecoration('قسم الاعلان'),
              style: TextStyle(fontSize: 12, color: _textColor),
              items: [
                'الوظائف الإدارية',
                'الوظائف الهندسية',
                'الوظائف الفنية',
                'الوظائف العمالية',
                'الوظائف التقنية',
                'الوظائف القانونية',
                'الوظائف التسويقية',
                'الوظائف البحثية'
              ]
                  .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _section = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('نوع الإعلان'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: _addType,
              decoration: _buildInputDecoration('نوع الإعلان'),
              style: TextStyle(fontSize: 12, color: _textColor),
              items: ['عرض(توفير وظيفة)', 'طلب (باحث عن عمل)']
                  .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _addType = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('نوع العمل'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: _jobType,
              decoration: _buildInputDecoration('نوع العمل'),
              style: TextStyle(fontSize: 12, color: _textColor),
              items: [
                'دوام كامل',
                'دوام جزئي',
                'تعاقد مؤقت',
                'تدريب',
                'عمل عن بعد',
                'عمل ميداني'
              ]
                  .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _jobType = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('التخصص الوظيفي'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: _jobSpecialization,
              decoration: _buildInputDecoration('التخصص الوظيفي'),
              style: TextStyle(fontSize: 12, color: _textColor),
              items: [
                'إداري',
                'تقني',
                'هندسي',
                'مالي ومحاسبي',
                'مبيعات وتسويق',
                'أخري'
              ]
                  .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _jobSpecialization = value!;
                });
              },
            ),
          ),
          if (_jobSpecialization == 'أخري') ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _jobTitleController,
                decoration:
                _buildInputDecoration('', hintText: 'ادخل المسمي الوظيفي'),
                style: TextStyle(fontSize: 12, color: _textColor),
              ),
            ),
          ],
          const SizedBox(height: 10),
          _buildSectionTitle('المؤهلات'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: _qualifications,
              decoration: _buildInputDecoration('المؤهلات'),
              style: TextStyle(fontSize: 12, color: _textColor),
              items: [
                'الثانوية العامة',
                'الدبلوم',
                'البكالوريوس',
                'الماجستير',
                'الدكتوراه'
              ]
                  .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _qualifications = value!;
                });
              },
            ),
          ),
          if (_addType == 'عرض(توفير وظيفة)') ...[
            const SizedBox(height: 10),
            _buildSectionTitle('عدد الشواغر'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _numberOfVacanciesController,
                decoration:
                _buildInputDecoration('', hintText: 'ادخل عدد الشواغر'),
                style: TextStyle(fontSize: 12, color: _textColor),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
          const SizedBox(height: 10),
          _buildSectionTitle('سنوات الخبرة'),
          if (_addType == 'عرض(توفير وظيفة)')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonFormField<String>(
                value: _yearsOfExperience,
                decoration: _buildInputDecoration('سنوات الخبرة'),
                style: TextStyle(fontSize: 12, color: _textColor),
                items: [
                  'بدون خبرة',
                  ' أقل من سنة',
                  ' 1-3 سنوات',
                  '3-5 سنوات',
                  'أكثر من 5 سنوات'
                ]
                    .map((label) => DropdownMenuItem(
                  value: label,
                  child: Text(label),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _yearsOfExperience = value!;
                  });
                },
              ),
            ),
          if (_addType == 'طلب (باحث عن عمل)')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _experienceController,
                decoration:
                _buildInputDecoration('', hintText: 'ادخل سنوات الخبرة'),
                style: TextStyle(fontSize: 12, color: _textColor),
                keyboardType: TextInputType.number,
              ),
            ),
          const SizedBox(height: 10),
          _buildSectionTitle('المهارات'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _buildMultiSelectDropdown(),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('ساعات العمل'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: _workTime,
              decoration: _buildInputDecoration('ساعات العمل'),
              style: TextStyle(fontSize: 12, color: _textColor),
              items: ['صباحية', 'مسائية', 'مرنة']
                  .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _workTime = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('الراتب'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: _salaryType,
              decoration: _buildInputDecoration('الراتب'),
              style: TextStyle(fontSize: 12, color: _textColor),
              items: ['قابل للتفاوض', 'محدد']
                  .map((label) => DropdownMenuItem(
                value: label,
                child: Text(label),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _salaryType = value!;
                });
              },
            ),
          ),
          if (_salaryType == 'محدد') ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _salaryController,
                decoration: _buildInputDecoration('', hintText: 'حدد السعر'),
                style: TextStyle(fontSize: 12, color: _textColor),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
          const SizedBox(height: 20),
          _buildNavigationButtons(
            onNext: () {
              if (_formKey.currentState!.validate()) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMultiSelectDropdown() {
    final availableSkills = [
      'إجادة استخدام الحاسوب',
      'مهارات القيادة',
      'إدارة الوقت',
      'العمل الجماعي',
      'التواصل الفعّال'
    ];

    return InkWell(
      onTap: () async {
        final selected = await showDialog<List<String>>(
          context: context,
          builder: (context) => _MultiSelectDialog(
            title: 'اختر المهارات',
            items: availableSkills,
            selectedItems: _skills,
          ),
        );
        if (selected != null) {
          setState(() {
            _skills = selected;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _borderColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _skills.isEmpty ? 'التواصل الفعّال' : _skills.join(', '),
                style: TextStyle(
                  fontSize: 12,
                  color: _skills.isEmpty
                      ? _textColor.withOpacity(0.4)
                      : _textColor,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: _textColor.withOpacity(0.6)),
          ],
        ),
      ),
    );
  }

  Widget _buildPage2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('الاسم'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _contactNameController,
              decoration: _buildInputDecoration('الاسم'),
              style: TextStyle(fontSize: 12, color: _textColor),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال الاسم';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('رقم الهاتف'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _contactPhoneController,
              decoration: _buildInputDecoration('رقم الهاتف'),
              style: TextStyle(fontSize: 12, color: _textColor),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال رقم الهاتف';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('البريد الإلكتروني'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _contactEmailController,
              decoration: _buildInputDecoration('البريد الإلكتروني'),
              style: TextStyle(fontSize: 12, color: _textColor),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('وسائل تواصل أخرى'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _otherContactController,
              decoration: _buildInputDecoration('وسائل تواصل أخرى'),
              style: TextStyle(fontSize: 12, color: _textColor),
            ),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle('ملاحظات إضافية'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: _additionalNotesController,
              decoration: _buildInputDecoration('ملاحظات إضافية'),
              style: TextStyle(fontSize: 12, color: _textColor),
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 20),
          _buildNavigationButtons(
            showBack: true,
            onBack: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            onNext: () {
              if (_formKey.currentState!.validate()) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPage3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_addType == 'عرض(توفير وظيفة)') ...[
            _buildFileUploadOption(
              icon: Icons.picture_as_pdf,
              title: 'تحميل وصف الوظيفة (PDF أو Word)',
            ),
            const SizedBox(height: 10),
            _buildFileUploadOption(
              icon: Icons.description,
              title: 'مستندات إضافية مثل سياسات الشركة',
            ),
          ],
          if (_addType == 'طلب (باحث عن عمل)') ...[
            _buildFileUploadOption(
              icon: Icons.work_outline,
              title: 'السيرة الذاتية (CV)',
            ),
            const SizedBox(height: 10),
            _buildFileUploadOption(
              icon: Icons.school,
              title: 'شهادات أكاديمية أو تدريبية',
            ),
          ],
          const SizedBox(height: 20),
          _buildNavigationButtons(
            showBack: true,
            onBack: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            onNext: () {
              // Save to Firebase here
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            nextLabel: 'إضافة المنتج',
          ),
        ],
      ),
    );
  }

  Widget _buildFileUploadOption({
    required IconData icon,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: _brownColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _textColor,
              ),
            ),
          ),
          Icon(Icons.upload_file, color: _accentColor, size: 24),
        ],
      ),
    );
  }

  Widget _buildPage4() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: _accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 60,
                color: _accentColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'تهانينا..\nلقد أضفت إعلانك بنجاح',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: _textColor,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 14, color: _textColor),
                  children: const [
                    TextSpan(
                      text: 'رقم الطلب: ',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: '#14535081',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'نقدّر اختيارك لنا! سنقوم بالتواصل معك خلال الـ 24 ساعة القادمة...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: _textColor.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _brownColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Navigate to shopping
                },
                child: const Text(
                  'استمر في التسوق',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Navigate to my ads
                },
                child: Text(
                  'تصفح أعلاناتي',
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons({
    bool showBack = false,
    VoidCallback? onBack,
    VoidCallback? onNext,
    String nextLabel = 'التالى',
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showBack)
            InkWell(
              onTap: onBack,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _brownColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          if (showBack) const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: onNext,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_accentColor, _accentColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: _accentColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nextLabel,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _textColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_back,
                      color: _textColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryColor,
      appBar: AppBar(
        backgroundColor: _brownColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'إعلان وظيفـــــــــــة',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: _buildNavigationIndicator(),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      _buildPage1(),
                      _buildPage2(),
                      _buildPage3(),
                      _buildPage4(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MultiSelectDialog extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItems;

  const _MultiSelectDialog({
    required this.title,
    required this.items,
    required this.selectedItems,
  });

  @override
  State<_MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<_MultiSelectDialog> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.items.map((item) {
            final isSelected = _selectedItems.contains(item);
            return CheckboxListTile(
              title: Text(item),
              value: isSelected,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _selectedItems.add(item);
                  } else {
                    _selectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _selectedItems),
          child: const Text('تأكيد'),
        ),
      ],
    );
  }
}