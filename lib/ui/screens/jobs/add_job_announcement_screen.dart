
import 'package:dotted_border/dotted_border.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class AddJobAnnouncementScreen extends StatefulWidget {
  const AddJobAnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AddJobAnnouncementScreen> createState() =>
      _AddJobAnnouncementScreenState();
}

class _AddJobAnnouncementScreenState extends State<AddJobAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _minSalaryController = TextEditingController();
  final TextEditingController _maxSalaryController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();

  String? _category = 'قسم التوظيف';
  String? _listingType;
  String? _employmentType;
  String? _education;
  String? _applicationMethod;
  String? _status = 'نشط';
  bool _isNegotiable = false;

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: context.color.textDefaultColor,
      ),
      filled: true,
      fillColor: context.color.secondaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: context.color.mainColor),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.primaryColor,
      appBar: UiUtils.buildAppBar(context,
          title: "اضافة اعلان توظيف",
          showBackButton: true,
          backgroundColor: context.color.mainBrown),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('المعلومات الأساسية'),
              TextFormField(
                controller: _titleController,
                decoration: _buildInputDecoration('عنوان الإعلان'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال عنوان الإعلان';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: _buildInputDecoration('الوصف التفصيلي'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال الوصف';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: _buildInputDecoration('الفئة/القسم'),
                items: ['قسم التوظيف']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('الصورة/الغلاف'),
              GestureDetector(
                onTap: () {
                  // TODO: Implement image picker
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  padding: EdgeInsets.all(6),
                  color: context.color.textDefaultColor,
                  strokeWidth: 1,
                  dashPattern: [6, 6],
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload_outlined,
                            size: 48, color: context.color.textDefaultColor),
                        const SizedBox(height: 8),
                        Text('اختر صورة'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: _buildInputDecoration('الموقع'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال الموقع';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: _buildInputDecoration('حالة الإعلان'),
                items: ['نشط', 'معلق', 'مغلق']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('تفاصيل التوظيف'),
              DropdownButtonFormField<String>(
                value: _listingType,
                decoration: _buildInputDecoration('نوع الإعلان'),
                hint: Text('اختر نوع الإعلان'),
                items: ['وظيفة', 'تدريب/تمرين', 'خدمة توظيف']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _listingType = value;
                    _employmentType =
                        null; // Reset employment type when listing type changes
                  });
                },
              ),
              if (_listingType == 'وظيفة') ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _employmentType,
                  decoration: _buildInputDecoration('نوع التوظيف'),
                  hint: Text('اختر نوع التوظيف'),
                  items: ['بدوام كامل', 'بدوام جزئي', 'عقد/استشارة']
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _employmentType = value;
                    });
                  },
                ),
              ],
              const SizedBox(height: 16),
               _buildSectionTitle('الراتب (اختياري)'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _minSalaryController,
                      decoration: _buildInputDecoration('الحد الأدنى'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _maxSalaryController,
                      decoration: _buildInputDecoration('الحد الأقصى'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isNegotiable,
                     activeColor: context.color.mainColor,
                    onChanged: (value) {
                      setState(() {
                        _isNegotiable = value ?? false;
                      });
                    },
                  ),
                  Text('قابل للتفاوض'),
                ],
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('المتطلبات (اختياري)'),
               TextFormField(
                controller: _requirementsController,
                decoration: _buildInputDecoration('المهارات المطلوبة'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _experienceController,
                decoration: _buildInputDecoration('سنوات الخبرة'),
                 keyboardType: TextInputType.number,
              ),
               const SizedBox(height: 16),
               DropdownButtonFormField<String>(
                value: _education,
                decoration: _buildInputDecoration('المؤهلات'),
                hint: Text('اختر المؤهل'),
                items: ['شهادة/دبلوم', 'بكالوريوس', 'ماجستير', 'دكتوراه']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _education = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deadlineController,
                readOnly: true,
                decoration: _buildInputDecoration('الموعد النهائي'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate = pickedDate.toString().split(' ')[0];
                    setState(() {
                       _deadlineController.text = formattedDate;
                    });
                  }
              },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _applicationMethod,
                decoration: _buildInputDecoration('طريقة التقديم'),
                hint: Text('اختر طريقة التقديم'),
                items: ['من خلال التطبيق', 'بريد إلكتروني', 'هاتفي']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _applicationMethod = value;
                  });
                },
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.color.mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                  }
                },
                child: Text('نشر الإعلان',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
