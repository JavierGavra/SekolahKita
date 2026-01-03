class MaterialModel {
  final String id;
  final String moduleId;
  final String title;
  final List<MaterialSection> sections;

  MaterialModel({
    required this.id,
    required this.moduleId,
    required this.title,
    required this.sections,
  });
}

class MaterialSection {
  final String type; // 'text', 'image', 'list', 'highlight'
  final String? content;
  final String? imageUrl;
  final List<String>? listItems;
  final String? highlightTitle;
  final String? highlightContent;

  MaterialSection({
    required this.type,
    this.content,
    this.imageUrl,
    this.listItems,
    this.highlightTitle,
    this.highlightContent,
  });
}
