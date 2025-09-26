import 'package:gestor_empreendimento/views/widgets/custom_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:gestor_empreendimento/views/pages/home.dart';
import 'package:gestor_empreendimento/views/pages/menu.dart';
import 'package:gestor_empreendimento/views/pages/receitas/receitas.dart';
import 'package:gestor_empreendimento/views/pages/mercadorias.dart';
import 'package:gestor_empreendimento/views/pages/insumos/insumos.dart';
import 'package:gestor_empreendimento/views/pages/insumos/insumo_criar.dart';
import 'package:gestor_empreendimento/views/pages/insumos/insumo_editar.dart';
import 'package:gestor_empreendimento/models/insumo.dart';
import 'package:gestor_empreendimento/views/pages/receitas/receita_criar.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Home()),
    GoRoute(
      path: '/menu',
      builder: (context, state) => const CustomScaffold(child: Menu()),
    ),
    GoRoute(
      path: '/receitas',
      builder: (context, state) => const CustomScaffold(child: Receitas()),
    ),
    GoRoute(
      path: '/mercadorias',
      builder: (context, state) => const CustomScaffold(child: Mercadorias()),
    ),
    GoRoute(
      path: '/insumos',
      builder: (context, state) => const CustomScaffold(child: Insumos()),
    ),
    GoRoute(
      path: '/insumos/add',
      builder: (context, state) => const CustomScaffold(child: InsumoCriar()),
    ),
    GoRoute(
      path: '/insumos/edit',
      builder: (context, state) =>
          CustomScaffold(child: InsumoEditar(insumo: state.extra as Insumo)),
    ),
    GoRoute(
      path: '/receitas/add',
      builder: (context, state) => const CustomScaffold(child: ReceitaCriar()),
    ),
  ],
);
