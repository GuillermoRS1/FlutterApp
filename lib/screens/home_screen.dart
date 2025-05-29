import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import '../widgets/item_card.dart';
import 'add_edit_screen.dart';
import '../models/item.dart';

// Home screen displaying a list of items.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load items when the screen initializes.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemProvider>().loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item Manager',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: const Color(0xFF09184D),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) {
          // Show loading indicator
          if (itemProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error message if any
          if (itemProvider.error != null) {
            return _buildErrorState(itemProvider);
          }

          // Show empty state
          if (itemProvider.items.isEmpty) {
            return const Center(
              child: Text(
                'No items found.\nTap + to add your first item!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          // Show list of items
          return RefreshIndicator(
            onRefresh: () => itemProvider.loadItems(),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: itemProvider.items.length,
              itemBuilder: (context, index) {
                final item = itemProvider.items[index];
                return ItemCard(
                  item: item,
                  onEdit: () => _navigateToAddEditScreen(context, item: item),
                  onDelete: () => _showDeleteConfirmation(context, item),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditScreen(context),
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF7B5BF2),
      ),
    );
  }

  /// Builds the error state UI.
  Widget _buildErrorState(ItemProvider itemProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            itemProvider.error!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              itemProvider.clearError();
              itemProvider.loadItems();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// Navigates to the add/edit screen.
  void _navigateToAddEditScreen(BuildContext context, {Item? item}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditScreen(item: item),
      ),
    );
  }

  /// Shows a delete confirmation dialog.
  void _showDeleteConfirmation(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: Text('Are you sure you want to delete "${item.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final success = await context.read<ItemProvider>().deleteItem(item.id!);
                if (!success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.read<ItemProvider>().error ?? 'Failed to delete item'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}