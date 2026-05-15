import 'package:flutter/material.dart';
import 'package:flutter_boxicons_example/boxicons_data.dart';

class BoxiconsGallery extends StatefulWidget {
  final int crossAxisCount;
  final double iconSize;

  const BoxiconsGallery({
    super.key,
    this.crossAxisCount = 4,
    this.iconSize = 32,
  });

  @override
  State<BoxiconsGallery> createState() => _BoxiconsGalleryState();
}

class _BoxiconsGalleryState extends State<BoxiconsGallery> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<BoxiconItem> get _filteredIcons {
    if (_searchQuery.isEmpty) return allBoxicons;
    return allBoxicons
        .where((item) =>
            item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search icons...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),
        Expanded(
          child: _filteredIcons.isEmpty
              ? const Center(child: Text('No icons found'))
              : GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _filteredIcons.length,
                  itemBuilder: (context, index) {
                    final item = _filteredIcons[index];
                    return Card(
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          // Optional: copy to clipboard or show snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(item.name),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, size: widget.iconSize),
                            const SizedBox(height: 8),
                            Flexible(
                              child: Text(
                                item.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 10),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
