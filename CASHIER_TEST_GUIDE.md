# Cashier Test Mode Guide

## How to Test the Cashier Feature

### Prerequisites
1. Ensure `Variables.isTestMode = true` in `lib/core/constants/variables.dart`
2. Run the Flutter application
3. Select "MULAI TESTING" from the welcome screen

### Testing the Cashier Transaction Interface

#### 1. Adding Products to Cart
- **Method 1**: Click "Pilih Barang" button to open product selection dialog
  - Search for products using the search bar
  - Click on any product card to add it to cart
- **Method 2**: Use quick access buttons for common items
- **Method 3**: Type product name in barcode field and press Enter

#### 2. Managing Cart Items
- **Increase Quantity**: Click the blue "+" button
- **Decrease Quantity**: Click the red "-" button  
- **Remove Item**: Click the delete (trash) icon

#### 3. Customer Selection
- Click the Customer dropdown
- Select from predefined customers:
  - Customer Umum (default)
  - AMIN
  - Yonglex
  - Pak Budi
  - Ibu Sari

#### 4. Payment Processing
- Select payment type (Cash, QRIS, Transfer)
- Enter cash amount in "Bayar" field
- Watch automatic change calculation
- Click "PROSES PEMBAYARAN" to complete transaction

### Testing Sales Invoice Interface

#### 1. Viewing Sales Data
- Navigate to "Penjualan" tab in cashier interface
- Browse through 10 sample transactions
- Use pagination controls at bottom

#### 2. Search Functionality
- Enter invoice number (e.g., "2025071339")
- Search by customer name (e.g., "AMIN")
- Search by cashier name (e.g., "Seniman Koding")

#### 3. Invoice Details
- Click the eye icon to view transaction details
- See complete item breakdown and totals

### Testing Piutang (Outstanding) Interface

#### 1. Outstanding Payments
- Navigate to "Piutang" tab
- Click "Belum Lunas" to see unpaid amounts
- View customer details and remaining balances

#### 2. Paid Transactions
- Click "Lunas" tab to see completed payments
- Review payment history and dates

#### 3. Processing Payments
- Click payment icon for outstanding items
- Enter payment amount
- Process payment (demo mode)

### Sample Test Scenarios

#### Scenario 1: Quick Sale
1. Open cashier transaction
2. Click "Oli Mesin Shell Helix" quick button
3. Select "Customer Umum"
4. Enter cash amount: 60000
5. Process payment

#### Scenario 2: Multiple Items
1. Click "Pilih Barang"
2. Add "Ban Michelin" (Rp. 112,000)
3. Add "Filter Udara" (Rp. 100,000)
4. Select customer "AMIN"
5. Enter cash: 250000
6. Process payment

#### Scenario 3: Search Invoice
1. Go to "Penjualan" tab
2. Search for "2025071339"
3. Click eye icon to view details
4. Verify customer is "Customer Umum"

### Expected Behaviors

#### Transaction Processing
- ✅ Invoice number automatically generated
- ✅ Cart totals update immediately
- ✅ Change calculated correctly
- ✅ Success message displayed
- ✅ Form resets after transaction

#### Search and Pagination
- ✅ Real-time search results
- ✅ Pagination works correctly
- ✅ "Showing X to Y of Z entries" accurate
- ✅ Page navigation functional

#### Data Consistency
- ✅ All dummy data displays correctly
- ✅ Indonesian currency formatting (Rp.)
- ✅ Proper date formatting
- ✅ Customer names in Indonesian

### Troubleshooting

#### Common Issues
1. **No products showing**: Verify `dummyProducts` in `data_dummy.dart`
2. **Search not working**: Check search query is not empty
3. **Payment validation**: Ensure cash amount >= total
4. **Navigation issues**: Verify all imports are correct

#### Debug Information
- All interactions logged to console with `debugPrint`
- Check Flutter console for navigation events
- Verify test mode indicator appears in app bar

### Data Available for Testing

#### Products (8 items)
- Oli Mesin Shell Helix: Rp. 56,000
- Ban Michelin 185/65R15: Rp. 112,000
- Filter Udara: Rp. 100,000
- Kampas Rem: Rp. 100,000
- Lampu Sein: Rp. 20,000
- Shock Absorber: Rp. 80,000
- Aki GS Astra: Rp. 350,000
- Busi NGK: Rp. 35,000

#### Transaction History (10 records)
- Date range: May 31, 2025 to July 13, 2025
- Various customers and cashiers
- Different payment amounts

#### Customers (5 predefined)
- Customer Umum (default)
- AMIN (081234567890)
- Yonglex (081234567891)
- Pak Budi (081234567892)
- Ibu Sari (081234567893)

This test mode provides a complete simulation of a real cashier environment without requiring backend connectivity.