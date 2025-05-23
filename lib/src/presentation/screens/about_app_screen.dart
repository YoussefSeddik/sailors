import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about_app'.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          '''
هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة.
لقد تم توليد هذا النص من مولد النص العربي.
حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى.
يزيد عدد السطور حسب الحاجة في التصميم.
لن يبدو هذا النص مقروءًا بشكل واضح بسبب توزيعه العشوائي.
إذا كنت تحتاج إلى نص حقيقي، يمكنك استبداله لاحقًا.
هذا النص مفيد لاختبار واجهات الاستخدام والتخطيطات.
يتم استخدام هذا النوع من النصوص كثيرًا في نماذج التطبيقات.
النص لا يعكس محتوى حقيقي بل يستخدم للتوضيح فقط.
يمكنك تعديل عدد السطور أو الكلمات حسب الحاجة.
النصوص التجريبية تساعد على تصور شكل المحتوى.
عادة ما يُستخدم في بداية المشاريع لإعداد التصميم.
هذا النص لا يحمل أي معنى حقيقي أو سياق معين.
يستخدم في الطباعة والنشر لتجربة الخطوط والمسافات.
يمكن تكراره أو تغييره بسهولة دون التأثير على التصميم.
يساعد على رؤية العناصر الرسومية بدون تشتيت.
يتم استبدال هذا النص بمحتوى فعلي لاحقًا.
يمكن استخدام هذا النموذج في صفحات الويب والتطبيقات.
إذا أردت تنسيقه، يمكنك استخدام أنماط متعددة.
انتهى النص التجريبي، يمكنك الآن إضافة المحتوى الحقيقي.
          ''',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
