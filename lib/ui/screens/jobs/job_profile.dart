import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class JobProfileScreen extends StatelessWidget {
  const JobProfileScreen({super.key});

  static const String routeName = 'jobProfile';
  static const String routePath = '/jobProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: UiUtils.buildAppBar(
        context,
        title: 'ملف المعلن',
        showBackButton: true,
        backgroundColor: context.color.mainBrown,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          physics: const BouncingScrollPhysics(),
          children: [
            _buildHeaderCard(context),
            const SizedBox(height: 12),
            _buildContactActions(context),
            const SizedBox(height: 12),
            _buildSectionCard(
              context,
              title: 'نبذة عن المعلن',
              child: const Text(
                'مهندس تعدين بخبرة تزيد عن 8 سنوات في تشغيل المناجم وإدارة فرق العمل. ملتزم بمعايير السلامة والجودة، وأعمل على تطوير بيئات العمل وتحسين الإنتاجية.',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ),
            const SizedBox(height: 12),
            _buildSectionCard(
              context,
              title: 'البيانات الأساسية',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _infoChip(context, Icons.business, 'الصفة', 'شركة تعدين'),
                  _infoChip(context, Icons.place, 'المدينة', 'الخرطوم'),
                  _infoChip(context, Icons.timer, 'سنوات الخبرة', '8+'),
                  _infoChip(context, Icons.work, 'نوع التوظيف', 'دوام كامل'),
                  _infoChip(context, Icons.school, 'المؤهل', 'بكالوريوس'),
                  _infoChip(context, Icons.verified, 'الحالة', 'موثق'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildSectionCard(
              context,
              title: 'الخبرات',
              child: Column(
                children: [
                  _experienceTile(
                    context,
                    title: 'مدير موقع - منجم الذهب',
                    subtitle: '2019 - حتى الآن',
                    details: 'إدارة عمليات التشغيل وتحسين خطوط الإنتاج.',
                  ),
                  const SizedBox(height: 10),
                  _experienceTile(
                    context,
                    title: 'مشرف سلامة',
                    subtitle: '2016 - 2019',
                    details: 'تطوير إجراءات السلامة والتدريب الميداني.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildSectionCard(
              context,
              title: 'المهارات',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _skillChip(context, 'إدارة فرق العمل'),
                  _skillChip(context, 'تحليل المخاطر'),
                  _skillChip(context, 'تخطيط الإنتاج'),
                  _skillChip(context, 'تقييم الجودة'),
                  _skillChip(context, 'تطوير العمليات'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildSectionCard(
              context,
              title: 'التواصل',
              child: Column(
                children: [
                  _contactRow(Icons.phone, 'الهاتف', '+249 90 000 0000'),
                  const SizedBox(height: 8),
                  _contactRow(Icons.email, 'البريد', 'advertiser@mining.com'),
                  const SizedBox(height: 8),
                  _contactRow(Icons.language, 'الموقع', 'mining-market.com'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildStatsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/profile.jpg',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'أحمد عبد الوهاب',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: context.color.mainGold,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'موثق',
                        style: TextStyle(fontSize: 11),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'مشرف عمليات تعدين',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < 4 ? Icons.star : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.place, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('الخرطوم', style: TextStyle(fontSize: 12)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContactActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            context,
            label: 'اتصال',
            icon: Icons.phone,
            background: context.color.mainGold,
            foreground: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _actionButton(
            context,
            label: 'مراسلة',
            icon: Icons.chat_bubble_outline,
            background: Colors.white,
            foreground: Colors.black,
            borderColor: Colors.grey.shade300,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _actionButton(
            context,
            label: 'مشاركة',
            icon: Icons.share,
            background: context.color.mainBrown,
            foreground: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(BuildContext context,
      {required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: context.color.mainGold,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _infoChip(
      BuildContext context, IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 248, 248, 248),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: context.color.mainBrown),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _experienceTile(BuildContext context,
      {required String title,
      required String subtitle,
      required String details}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 6),
          Text(
            details,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _skillChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: context.color.mainGold.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.color.mainGold),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _contactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade700),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statItem(context, 'الإعلانات', '12'),
          _statItem(context, 'الرد خلال', '2 ساعات'),
          _statItem(context, 'نسبة الرد', '92%'),
        ],
      ),
    );
  }

  Widget _statItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color background,
    required Color foreground,
    Color? borderColor,
  }) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null ? Border.all(color: borderColor) : null,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(10, 0, 0, 0),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: foreground),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: foreground),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(12, 0, 0, 0),
          offset: Offset(0, 2),
          blurRadius: 10,
          spreadRadius: 4,
        )
      ],
    );
  }
}
