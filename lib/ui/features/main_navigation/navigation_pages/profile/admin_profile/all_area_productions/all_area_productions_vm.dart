import 'package:flutter/material.dart';
import 'package:amca/data/api/production_city.dart';
import 'package:amca/data/repository/state_repository.dart';
import 'package:amca/domain/model/state.dart' as domain_state;

/// ViewModel mínimo para la pantalla de reportes por área/municipio.
///
/// Nota: actualmente usa datos simulados. Reemplazar las llamadas a
/// los repositorios o APIs por las funciones reales cuando estén
/// disponibles (por ejemplo en `lib/data/api/production_city.dart`).
class AllAreaProductionsVm extends ChangeNotifier {

  final String ownerId;

  bool isLoading = false;

  /// Lista de ciudades (municipios) disponibles para el usuario propietario de fincas.
  List<String> cities = [];

  /// Tipos de producto mostrados en el filtro.
  final List<String> productTypes = [
    'Selecciona tipo de producción',
    'Agrícola',
    'Ganadería - Leche',
    'Ganadería - Cárnicos',
    'Ganadería - Porcicola',
    'Piscicultura',
  ];

  String? selectedCity;
  String? selectedProductType;
  String? selectedDepartment;

  /// Lista de departamentos (para filtrar ciudades)
  List<String> departments = [];

  /// Estados cargados desde el repositorio (para referencia al filtrar)
  List<domain_state.State> _states = [];

  /// Contiene métricas simples por municipio según el filtro seleccionado.
  /// Ejemplo:
  /// {
  ///   'areaSembrada': 120.5,
  ///   'numAnimales': 350,
  ///   'areaTotalProduccion': 45.2,
  /// }
  Map<String, dynamic> metrics = {};

  /// Controladores para los campos de selección (útiles si se usan widgets que los requieren).
  final TextEditingController cityController = TextEditingController();
  final TextEditingController productTypeController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  final StateRepository stateRepository;
  final ProductionCityApi _productionCityApi = ProductionCityApi();

  AllAreaProductionsVm({required this.ownerId, StateRepository? stateRepository})
    : stateRepository = stateRepository ?? StateRepositoryAdapter();

  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    // Cargar ciudades reales desde el repositorio a partir del JSON local.
    try {
      final List<domain_state.State> states = await stateRepository.getStates();
      _states = states;

      // departamentos
      final deptSet = <String>{};
      for (final s in states) {
        if (s.departamento != null) deptSet.add(s.departamento!);
      }
      final deptList = deptSet.toList()..sort();
      departments = ['Selecciona departamento', ...deptList];

      // inicialmente no cargamos ciudades hasta que el usuario seleccione departamento
      cities = ['Selecciona ciudad'];
    } catch (e) {
      // Fallback: mantener una lista mínima si algo falla.
      cities = ['Selecciona ciudad'];
    }

    // valores por defecto
    selectedDepartment = departments.isNotEmpty ? departments.first : null;
    departmentController.text = selectedDepartment ?? '';

    selectedCity = cities.isNotEmpty ? cities.first : null;
    cityController.text = selectedCity ?? '';

  // No product selected by default (placeholder shown in options).
  selectedProductType = null;
  productTypeController.text = '';

    // cargar métricas iniciales (vacías)
    metrics = {};

    isLoading = false;
    notifyListeners();
  }

  void selectCity(String city) {
    selectedCity = city;
    cityController.text = city;
    notifyListeners();
    // recargar métricas
    loadMetrics();
  }

  void selectProductType(String type) {
    // If user selects placeholder, clear selection and metrics and do not load.
    if (type == productTypes.first) {
      selectedProductType = null;
      productTypeController.text = '';
      metrics = {};
      notifyListeners();
      return;
    }

    selectedProductType = type;
    productTypeController.text = type;
    notifyListeners();
    loadMetrics();
  }

  void selectDepartment(String department) {
    selectedDepartment = department;
    departmentController.text = department;

    // buscar el estado correspondiente y cargar sus ciudades
    final found = _states.firstWhere(
      (s) => s.departamento == department,
      orElse: () => domain_state.State(departamento: null, ciudades: []),
    );
    final cityList = (found.ciudades ?? []).toList()..sort();
    cities = ['Selecciona ciudad', ...cityList];

    // resetear selección de ciudad
    selectedCity = cities.isNotEmpty ? cities.first : null;
    cityController.text = selectedCity ?? '';

    notifyListeners();
  }

  /// Carga métricas según `selectedCity` y `selectedProductType`.
  /// Actualmente devuelve datos simulados; sustituir por lógica real.
  Future<void> loadMetrics() async {
    if (selectedCity == null || selectedProductType == null) return;

    isLoading = true;
    notifyListeners();

    try {
      if (selectedProductType == 'Agrícola') {
        final areaByCrop = await _productionCityApi.getSownAreaByCropByCity(
          selectedDepartment ?? '', selectedCity ?? '',
        );
        final total = areaByCrop.values.fold<double>(0.0, (p, e) => p + e);
        metrics = {'areaSembrada': total, 'areaByCrop': areaByCrop};
      } else if (selectedProductType == 'Piscicultura') {
        final fish = await _productionCityApi.getFishMetricsByCity(
          selectedDepartment ?? '', selectedCity ?? '',
        );
          metrics = {
            'numPorMunicipio': fish['numberAnimals'] ?? 0,
            'areaTotalProduccion': fish['areaHectares'] ?? 0.0,
            'volumeCubicMeters': fish['volumeCubicMeters'] ?? 0.0,
          };
      } else {
        // Ganadería (lechera, porcicola, cárnicos)
        Map<String, dynamic> agg;
        if (selectedProductType!.contains('Porcicola') || selectedProductType!.contains('Porc')) {
          agg = await _productionCityApi.getPigMetricsByCity(selectedDepartment ?? '', selectedCity ?? '');
        } else if (selectedProductType!.contains('Leche') || selectedProductType!.contains('Milk')) {
          agg = await _productionCityApi.getMilkMetricsByCity(selectedDepartment ?? '', selectedCity ?? '');
        } else {
          agg = await _productionCityApi.getMeatMetricsByCity(selectedDepartment ?? '', selectedCity ?? '');
        }
        metrics = {
          'numAnimales': agg['numberAnimals'] ?? 0,
          'areaTotalProduccion': agg['areaHectares'] ?? 0.0,
        };
      }
    } catch (e) {
      metrics = {'error': 'No se pudo cargar métricas'};
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    cityController.dispose();
    productTypeController.dispose();
    departmentController.dispose();
    super.dispose();
  }
}
