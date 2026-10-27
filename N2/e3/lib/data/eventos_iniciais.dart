import '../models/evento.dart';

List<Evento> criarEventosIniciais() {
  return [
    Evento(
      id: 1,
      titulo: 'Introducao ao Flutter',
      local: 'Sala A10',
      categoria: 'Tecnologia',
      descricao: 'Oficina introdutoria sobre widgets, layout e estado local.',
    ),
    Evento(
      id: 2,
      titulo: 'Game Design na Pratica',
      local: 'Auditorio',
      categoria: 'Jogos',
      descricao: 'Palestra sobre experiencia, mecanicas, sistemas e gameplay.',
      inscrito: true,
    ),
    Evento(
      id: 3,
      titulo: 'Como montar um portfolio',
      local: 'Sala E14',
      categoria: 'Carreira',
      descricao: 'Encontro sobre portfolio, apresentacao de projetos e entrevistas.',
    ),
    Evento(
      id: 4,
      titulo: 'Iniciacao Cientifica',
      local: 'Sala B03',
      categoria: 'Pesquisa',
      descricao: 'Conversa sobre projetos, orientacao e producao academica.',
    ),
  ];
}
