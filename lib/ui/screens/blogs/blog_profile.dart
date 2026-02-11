import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BlogProfile extends StatelessWidget {
  const BlogProfile({Key? key}) : super(key: key);

  @override


  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: context.color.mainColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [context.color.mainColor, context.color.mainGold],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/edit-profile'),
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: context.color.mainGold,
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: context.color.mainGold,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF02AD11),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'د. محمد أحمد السعيد',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'مهندس تعدين أول | استشاري معادن',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: context.color.mainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'التخصص: جيولوجيا الاستكشاف',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.color.mainGold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              size: 16,
                              color: context.color.mainGold,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '15 سنة خبرة',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'خبير في مجال التعدين والمعادن مع أكثر من 15 عاماً من الخبرة',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: context.color.mainColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatColumn('24', 'مقالات'),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.grey,
                              ),
                              _buildStatColumn('8', 'كتب'),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.grey.shade400,
                              ),
                              _buildStatColumn('2.5K', 'متابع'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(color: Colors.grey.shade400, thickness: 1),
                        const SizedBox(height: 20),
                        _buildSectionTitle('السيرة الذاتية'),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: const Text(
                            'خبير متخصص في جيولوجيا الاستكشاف مع أكثر من 15 عاماً من الخبرة العملية في مجال التعدين والمعادن. حاصل على دكتوراه في هندسة التعدين من جامعة الملك فهد للبترول والمعادن. شارك في العديد من المشاريع الكبرى في المملكة والمنطقة العربية، مع تركيز خاص على تطوير تقنيات الاستكشاف الحديثة وتحسين كفاءة العمليات التعدينية. له العديد من الأبحاث المنشورة في المجلات العلمية المحكمة.',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.8,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('التعليم'),
                        const SizedBox(height: 12),
                        _buildInfoTile(
                          Icons.school,
                          'دكتوراه في هندسة التعدين',
                          'جامعة الملك فهد للبترول والمعادن',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoTile(
                          Icons.school_outlined,
                          'ماجستير في جيولوجيا الاستكشاف',
                          'جامعة الملك عبدالعزيز - 2008',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoTile(
                          Icons.school_outlined,
                          'بكالوريوس في هندسة التعدين',
                          'جامعة الملك فهد للبترول والمعادن - 2005',
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle('الخبرات'),
                        const SizedBox(height: 12),
                        _buildInfoTile(
                          Icons.work,
                          'كبير المهندسين',
                          'شركة معادن - 2015 حتى الآن',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoTile(
                          Icons.work_outline,
                          'مهندس تعدين',
                          'شركة التعدين الوطنية - 2010 إلى 2015',
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle('المشاريع البارزة'),
                        const SizedBox(height: 12),
                        _buildProjectCard(
                          'مشروع استكشاف الذهب - منطقة الدوادمي',
                          '2020-2022',
                          'قيادة فريق استكشاف وتحديد احتياطيات بقيمة 500 مليون ريال',
                        ),
                        const SizedBox(height: 8),
                        _buildProjectCard(
                          'تطوير منجم الفوسفات - الجوف',
                          '2018-2020',
                          'إدارة المشروع وزيادة الإنتاجية بنسبة 35%',
                        ),
                        const SizedBox(height: 8),
                        _buildProjectCard(
                          'دراسة جدوى منجم النحاس - تبوك',
                          '2016-2018',
                          'إعداد دراسات فنية واقتصادية شاملة',
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle('الإنجازات'),
                        const SizedBox(height: 12),
                        _buildInfoTile(
                          Icons.emoji_events,
                          'جائزة التميز في البحث العلمي',
                          '2022',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoTile(
                          Icons.emoji_events,
                          'جائزة الابتكار في التعدين المستدام',
                          'المؤتمر الدولي للتعدين - 2021',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoTile(
                          Icons.emoji_events,
                          'أفضل ورقة بحثية في جيولوجيا الاستكشاف',
                          'الجمعية السعودية لعلوم الأرض - 2019',
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle('الشهادات والمؤهلات'),
                        const SizedBox(height: 12),
                        _buildCertificateCard(
                          'شهادة مهندس محترف (PE)',
                          'الهيئة السعودية للمهندسين - 2015',
                          Icons.verified,
                        ),
                        const SizedBox(height: 8),
                        _buildCertificateCard(
                          'شهادة السلامة المهنية OSHA',
                          'المعهد الأمريكي للسلامة - 2017',
                          Icons.health_and_safety,
                        ),
                        const SizedBox(height: 8),
                        _buildCertificateCard(
                          'دورة إدارة المشاريع PMP',
                          'معهد إدارة المشاريع - 2019',
                          Icons.assignment_turned_in,
                        ),
                        const SizedBox(height: 8),
                        _buildCertificateCard(
                          'دورة GIS المتقدمة للتعدين',
                          'جامعة ستانفورد - 2020',
                          Icons.map,
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle('الروابط المهنية'),
                        const SizedBox(height: 12),
                        _buildLinkTile(
                            'الموقع الشخصي', 'www.example-expert.com'),
                        const SizedBox(height: 8),
                        _buildLinkTile('LinkedIn', 'linkedin.com/in/example'),
                        const SizedBox(height: 8),
                        _buildLinkTile(
                            'ResearchGate', 'researchgate.net/profile'),
                        const SizedBox(height: 8),
                        _buildLinkTile(
                            'Google Scholar', 'scholar.google.com/citations'),
                        const SizedBox(height: 8),
                        _buildLinkTile('Twitter', '@mining_expert'),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              size: 20,
              color: const Color(0xFFEBBE25),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile(String title, String url) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          right: BorderSide(
            color: Color(0xFFEBBE25),
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.link,
            size: 18,
            color: Color(0xFFEBBE25),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  url,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFEBBE25),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, String period, String description) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFFFF3E0),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.engineering,
                  size: 20,
                  color: Color(0xFFEBBE25),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      period,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFEBBE25),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(String title, String issuer, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          right: BorderSide(
            color: Color(0xFF02AD11),
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF02AD11),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              size: 20,
              color: const Color(0xFF02AD11),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  issuer,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.file_download_outlined,
            size: 20,
            color: Color(0xFFEBBE25),
          ),
        ],
      ),
    );
  }
}
