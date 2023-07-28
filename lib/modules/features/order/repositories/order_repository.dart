class OrderRepository {
  List<Map<String, dynamic>> ongoingOrder = [
    {
      "id_order": 35,
      "no_struk": "001/KWT/01/2022",
      "nama": "dev noersy",
      "total_bayar": 12000,
      "tanggal": "2023-06-19",
      "status": 0,
      "menu": [
        {
          "id_menu": 9,
          "kategori": "makanan",
          "nama": "Nasi Goreng",
          "foto": "https://i.ibb.co/mRJnq3Z/nasi-goreng.jpg",
          "jumlah": 1,
          "harga": "10000",
          "total": 10000,
          "catatan": "test"
        }
      ]
    },
    {
      "id_order": 37,
      "no_struk": "002/KWT/01/2022",
      "nama": "dev noersy",
      "total_bayar": 46000,
      "tanggal": "2023-06-18",
      "status": 3,
      "menu": [
        {
          "id_menu": 3,
          "kategori": "minuman",
          "nama": "Lemon Tea",
          "foto": "https://i.ibb.co/RNXcV2s/chicken-katsu.jpg",
          "jumlah": 2,
          "harga": "18000",
          "total": 36000,
          "catatan": "Testing"
        },
        {
          "id_menu": 9,
          "kategori": "makanan",
          "nama": "Nasi Goreng",
          "foto": "https://i.ibb.co/mRJnq3Z/nasi-goreng.jpg",
          "jumlah": 1,
          "harga": "10000",
          "total": 10000,
          "catatan": ""
        }
      ]
    },
    {
      "id_order": 38,
      "no_struk": "003/KWT/01/2022",
      "nama": "dev noersy",
      "total_bayar": 8100,
      "tanggal": "2023-06-19",
      "status": 1,
      "menu": [
        {
          "id_menu": 9,
          "kategori": "makanan",
          "nama": "Nasi Goreng",
          "foto": "https://i.ibb.co/mRJnq3Z/nasi-goreng.jpg",
          "jumlah": 1,
          "harga": "9000",
          "total": 9000,
          "catatan": "Testing"
        }
      ]
    },
    {
      "id_order": 40,
      "no_struk": "005/KWT/01/2022",
      "nama": "dev noersy",
      "total_bayar": 8100,
      "tanggal": "2023-05-01",
      "status": 4,
      "menu": [
        {
          "id_menu": 9,
          "kategori": "makanan",
          "nama": "Nasi Goreng",
          "foto": "https://i.ibb.co/mRJnq3Z/nasi-goreng.jpg",
          "jumlah": 1,
          "harga": "9000",
          "total": 9000,
          "catatan": "Testing"
        }
      ]
    }
  ];

  // Get Ongoing Order
  List<Map<String, dynamic>> getOngoingOrder() {
    return ongoingOrder.where((element) => element['status'] < 3).toList();
  }

  // Get Order History
  List<Map<String, dynamic>> getOrderHistory() {
    return ongoingOrder.where((element) => element['status'] > 2).toList();
  }

  // Get Order Detail
  Map<String, dynamic>? getOrderDetail(int idOrder) {
    return ongoingOrder.firstWhere((element) => element['id_order'] == idOrder,
        orElse: () => {});
  }
}
