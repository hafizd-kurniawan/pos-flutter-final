import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_responsive_app/core/constants/colors.dart';
import 'package:flutter_pos_responsive_app/data/models/response/customer_response_model.dart';
import 'package:flutter_pos_responsive_app/presentation/customer/bloc/customer_bloc.dart';

class CustomerSelectionDialog extends StatefulWidget {
  final Function(Customer) onCustomerSelected;
  final Customer? selectedCustomer;

  const CustomerSelectionDialog({
    super.key,
    required this.onCustomerSelected,
    this.selectedCustomer,
  });

  @override
  State<CustomerSelectionDialog> createState() => _CustomerSelectionDialogState();
}

class _CustomerSelectionDialogState extends State<CustomerSelectionDialog> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  
  bool _isAddingCustomer = false;

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(GetCustomersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_search,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _isAddingCustomer ? 'Tambah Customer' : 'Pilih Customer',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            
            // Action Buttons
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isAddingCustomer = false;
                        });
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Cari Customer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_isAddingCustomer 
                            ? AppColors.primary 
                            : Colors.grey[300],
                        foregroundColor: !_isAddingCustomer 
                            ? Colors.white 
                            : Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isAddingCustomer = true;
                        });
                      },
                      icon: const Icon(Icons.person_add),
                      label: const Text('Tambah Baru'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isAddingCustomer 
                            ? AppColors.primary 
                            : Colors.grey[300],
                        foregroundColor: _isAddingCustomer 
                            ? Colors.white 
                            : Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: _isAddingCustomer ? _buildAddCustomerForm() : _buildSearchCustomers(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCustomers() {
    return Column(
      children: [
        // Search Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Cari nama atau telepon customer...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, 
                vertical: 12,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  context.read<CustomerBloc>().add(GetCustomersEvent());
                },
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                context.read<CustomerBloc>().add(SearchCustomersEvent(value));
              } else {
                context.read<CustomerBloc>().add(GetCustomersEvent());
              }
            },
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Customer List
        Expanded(
          child: BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              if (state is CustomerLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CustomerLoaded) {
                return _buildCustomerList(state.customers);
              } else if (state is CustomerError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${state.message}',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CustomerBloc>().add(GetCustomersEvent());
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Tidak ada data customer'));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerList(List<Customer> customers) {
    if (customers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Tidak ada customer ditemukan',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: customers.length,
      itemBuilder: (context, index) {
        final customer = customers[index];
        final isSelected = widget.selectedCustomer?.id == customer.id;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: isSelected ? AppColors.primary : Colors.grey[300],
              child: Icon(
                Icons.person,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
            title: Text(
              customer.name ?? 'Unknown',
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (customer.phone?.isNotEmpty == true) ...[
                  const SizedBox(height: 4),
                  Text(
                    customer.phone!,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                if (customer.address?.isNotEmpty == true) ...[
                  const SizedBox(height: 2),
                  Text(
                    customer.address!,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
            trailing: isSelected 
                ? const Icon(Icons.check_circle, color: AppColors.primary)
                : const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              widget.onCustomerSelected(customer);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  Widget _buildAddCustomerForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nama Customer *',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Nomor Telepon',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.phone),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Alamat',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.location_on),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _submitCustomer(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Simpan Customer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitCustomer() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama customer harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final customerData = {
      'name': _nameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'address': _addressController.text.trim(),
    };

    context.read<CustomerBloc>().add(CreateCustomerEvent(customerData));
    
    // Listen for success and close dialog
    context.read<CustomerBloc>().stream.listen((state) {
      if (state is CustomerSuccess) {
        if (state.customer != null) {
          widget.onCustomerSelected(state.customer!);
          Navigator.of(context).pop();
        }
      }
    });
  }
}