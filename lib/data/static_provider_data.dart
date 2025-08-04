import 'models/provider_model.dart';

class StaticProviderData {
  static List<ProviderModel> getProvidersForService(String serviceId) {
    final now = DateTime.now();

    // Extract category ID from service ID (e.g., "1_basic_1" -> "1")
    final categoryId = serviceId.split('_')[0];

    switch (categoryId) {
      case '1': // Cleaning Service
        return _getCleaningProviders(now, serviceId);
      case '2': // Plumbing Service
        return _getPlumbingProviders(now, serviceId);
      case '3': // Electrical Service
        return _getElectricalProviders(now, serviceId);
      case '4': // Painting Service
        return _getPaintingProviders(now, serviceId);
      case '5': // Gardening Service
        return _getGardeningProviders(now, serviceId);
      case '6': // Moving Service
        return _getMovingProviders(now, serviceId);
      case '7': // Babysitting Service
        return _getBabysittingProviders(now, serviceId);
      case '8': // Car Wash Service
        return _getCarWashProviders(now, serviceId);
      default:
        return _getGeneralProviders(now, serviceId);
    }
  }

  static List<ProviderModel> _getCleaningProviders(
    DateTime now,
    String serviceId,
  ) {
    return [
      ProviderModel(
        id: 'p1',
        name: 'CleanPro Services',
        email: 'info@cleanpro.com',
        phone: '+9647501234567',
        address: 'Erbil, 100m Street',
        image: 'assets/images/logo.png',
        rating: 4.8,
        price: 25.0,
        serviceId: serviceId,
        isActive: true,
        createdAt: now,
        updatedAt: now,
        description: 'Professional cleaning services with 5 years experience',
        specializations: ['House Cleaning', 'Office Cleaning', 'Deep Cleaning'],
      ),
      ProviderModel(
        id: 'p2',
        name: 'Sparkle Clean',
        email: 'contact@sparkleclean.com',
        phone: '+9647501234568',
        address: 'Erbil, 60m Street',
        image: 'assets/images/logo.png',
        rating: 4.6,
        price: 30.0,
        serviceId: serviceId,
        isActive: true,
        createdAt: now,
        updatedAt: now,
        description: 'Eco-friendly cleaning solutions',
        specializations: ['Eco Cleaning', 'Window Cleaning'],
      ),
      // Add 18 more cleaning providers...
      for (int i = 3; i <= 20; i++)
        ProviderModel(
          id: 'p$i',
          name: 'Cleaning Provider $i',
          email: 'provider$i@cleaning.com',
          phone: '+9647501234${567 + i}',
          address: 'Erbil, ${i * 50}m Street',
          image: 'assets/images/logo.png',
          rating: 4.0 + (i % 10) * 0.1,
          price: 20.0 + (i % 10) * 2.0,
          serviceId: serviceId,
          isActive: true,
          createdAt: now,
          updatedAt: now,
          description: 'Professional cleaning service provider $i',
          specializations: ['Cleaning Service $i'],
        ),
    ];
  }

  static List<ProviderModel> _getPlumbingProviders(
    DateTime now,
    String serviceId,
  ) {
    return [
      ProviderModel(
        id: 'p21',
        name: 'QuickFix Plumbing',
        email: 'service@quickfix.com',
        phone: '+9647501234587',
        address: 'Erbil, 100m Street',
        image: 'assets/images/logo.png',
        rating: 4.7,
        price: 40.0,
        serviceId: serviceId,
        isActive: true,
        createdAt: now,
        updatedAt: now,
        description: '24/7 emergency plumbing services',
        specializations: ['Emergency Repair', 'Pipe Installation'],
      ),
      ProviderModel(
        id: 'p22',
        name: 'Master Plumbers',
        email: 'info@masterplumbers.com',
        phone: '+9647501234588',
        address: 'Erbil, 60m Street',
        image: 'assets/images/logo.png',
        rating: 4.5,
        price: 45.0,
        serviceId: serviceId,
        isActive: true,
        createdAt: now,
        updatedAt: now,
        description: 'Certified plumbing experts',
        specializations: ['Water Heater Repair', 'Drain Cleaning'],
      ),
      // Add 18 more plumbing providers...
      for (int i = 23; i <= 40; i++)
        ProviderModel(
          id: 'p$i',
          name: 'Plumbing Provider $i',
          email: 'provider$i@plumbing.com',
          phone: '+9647501234${587 + i}',
          address: 'Erbil, ${(i - 20) * 50}m Street',
          image: 'assets/images/logo.png',
          rating: 4.0 + (i % 10) * 0.1,
          price: 35.0 + (i % 10) * 3.0,
          serviceId: serviceId,
          isActive: true,
          createdAt: now,
          updatedAt: now,
          description: 'Professional plumbing service provider $i',
          specializations: ['Plumbing Service $i'],
        ),
    ];
  }

  static List<ProviderModel> _getElectricalProviders(
    DateTime now,
    String serviceId,
  ) {
    return [
      for (int i = 41; i <= 60; i++)
        ProviderModel(
          id: 'p$i',
          name: 'Electrical Provider $i',
          email: 'provider$i@electrical.com',
          phone: '+9647501234${607 + i}',
          address: 'Erbil, ${(i - 40) * 50}m Street',
          image: 'assets/images/logo.png',
          rating: 4.0 + (i % 10) * 0.1,
          price: 45.0 + (i % 10) * 4.0,
          serviceId: serviceId,
          isActive: true,
          createdAt: now,
          updatedAt: now,
          description: 'Professional electrical service provider $i',
          specializations: ['Electrical Service $i'],
        ),
    ];
  }

  static List<ProviderModel> _getPaintingProviders(
    DateTime now,
    String serviceId,
  ) {
    return [
      for (int i = 61; i <= 80; i++)
        ProviderModel(
          id: 'p$i',
          name: 'Painting Provider $i',
          email: 'provider$i@painting.com',
          phone: '+9647501234${627 + i}',
          address: 'Erbil, ${(i - 60) * 50}m Street',
          image: 'assets/images/logo.png',
          rating: 4.0 + (i % 10) * 0.1,
          price: 50.0 + (i % 10) * 5.0,
          serviceId: serviceId,
          isActive: true,
          createdAt: now,
          updatedAt: now,
          description: 'Professional painting service provider $i',
          specializations: ['Painting Service $i'],
        ),
    ];
  }

  static List<ProviderModel> _getGardeningProviders(
    DateTime now,
    String serviceId,
  ) {
    return [
      for (int i = 81; i <= 100; i++)
        ProviderModel(
          id: 'p$i',
          name: 'Gardening Provider $i',
          email: 'provider$i@gardening.com',
          phone: '+9647501234${647 + i}',
          address: 'Erbil, ${(i - 80) * 50}m Street',
          image: 'assets/images/logo.png',
          rating: 4.0 + (i % 10) * 0.1,
          price: 30.0 + (i % 10) * 3.0,
          serviceId: serviceId,
          isActive: true,
          createdAt: now,
          updatedAt: now,
          description: 'Professional gardening service provider $i',
          specializations: ['Gardening Service $i'],
        ),
    ];
  }

  static List<ProviderModel> _getMovingProviders(
    DateTime now,
    String serviceId,
  ) {
    return [
      for (int i = 101; i <= 120; i++)
        ProviderModel(
          id: 'p$i',
          name: 'Moving Provider $i',
          email: 'provider$i@moving.com',
          phone: '+9647501234${667 + i}',
          address: 'Erbil, ${(i - 100) * 50}m Street',
          image: 'assets/images/logo.png',
          rating: 4.0 + (i % 10) * 0.1,
          price: 70.0 + (i % 10) * 8.0,
          serviceId: serviceId,
          isActive: true,
          createdAt: now,
          updatedAt: now,
          description: 'Professional moving service provider $i',
          specializations: ['Moving Service $i'],
        ),
    ];
  }

  static List<ProviderModel> _getBabysittingProviders(
    DateTime now,
    String serviceId,
  ) {
    return [
      for (int i = 121; i <= 140; i++)
        ProviderModel(
          id: 'p$i',
          name: 'Babysitting Provider $i',
          email: 'provider$i@babysitting.com',
          phone: '+9647501234${687 + i}',
          address: 'Erbil, ${(i - 120) * 50}m Street',
          image: 'assets/images/logo.png',
          rating: 4.0 + (i % 10) * 0.1,
          price: 15.0 + (i % 10) * 2.0,
          serviceId: serviceId,
          isActive: true,
          createdAt: now,
          updatedAt: now,
          description: 'Professional babysitting service provider $i',
          specializations: ['Babysitting Service $i'],
        ),
    ];
  }

  static List<ProviderModel> _getCarWashProviders(
    DateTime now,
    String serviceId,
  ) {
    return [
      for (int i = 141; i <= 160; i++)
        ProviderModel(
          id: 'p$i',
          name: 'Car Wash Provider $i',
          email: 'provider$i@carwash.com',
          phone: '+9647501234${707 + i}',
          address: 'Erbil, ${(i - 140) * 50}m Street',
          image: 'assets/images/logo.png',
          rating: 4.0 + (i % 10) * 0.1,
          price: 25.0 + (i % 10) * 3.0,
          serviceId: serviceId,
          isActive: true,
          createdAt: now,
          updatedAt: now,
          description: 'Professional car wash service provider $i',
          specializations: ['Car Wash Service $i'],
        ),
    ];
  }

  static List<ProviderModel> _getGeneralProviders(
    DateTime now,
    String serviceId,
  ) {
    return [
      ProviderModel(
        id: 'p161',
        name: 'General Service Provider',
        email: 'info@generalservice.com',
        phone: '+9647501234607',
        address: 'Erbil, 100m Street',
        image: 'assets/images/logo.png',
        rating: 4.5,
        price: 50.0,
        serviceId: serviceId,
        isActive: true,
        createdAt: now,
        updatedAt: now,
        description: 'Professional service provider',
        specializations: ['General Services'],
      ),
    ];
  }

  static ProviderModel? getProviderById(String providerId) {
    final now = DateTime.now();
    final allProviders = [
      ..._getCleaningProviders(now, '1_basic_1'),
      ..._getPlumbingProviders(now, '2_basic_1'),
      ..._getElectricalProviders(now, '3_basic_1'),
      ..._getPaintingProviders(now, '4_basic_1'),
      ..._getGardeningProviders(now, '5_basic_1'),
      ..._getMovingProviders(now, '6_basic_1'),
      ..._getBabysittingProviders(now, '7_basic_1'),
      ..._getCarWashProviders(now, '8_basic_1'),
      ..._getGeneralProviders(now, '9_basic_1'),
    ];

    try {
      return allProviders.firstWhere((provider) => provider.id == providerId);
    } catch (e) {
      return null;
    }
  }
}
