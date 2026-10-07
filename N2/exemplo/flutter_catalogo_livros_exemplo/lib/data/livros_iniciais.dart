import '../models/livro.dart';

List<Livro> criarLivrosIniciais() {
  return [
    Livro(
      id: 1,
      titulo: 'Flutter para Iniciantes',
      autor: 'Equipe Exemplo',
      categoria: 'Tecnologia',
      descricao: 'Um livro introdutorio sobre widgets, estado e composicao.',
      favorito: true,
    ),
    Livro(
      id: 2,
      titulo: 'O Hobbit',
      autor: 'J. R. R. Tolkien',
      categoria: 'Fantasia',
      descricao: 'Uma aventura classica usada aqui apenas como dado de exemplo.',
    ),
    Livro(
      id: 3,
      titulo: 'Fundacao',
      autor: 'Isaac Asimov',
      categoria: 'Ficcao',
      descricao: 'Exemplo de item para demonstrar lista, filtro e detalhes.',
    ),
    Livro(
      id: 4,
      titulo: 'Design de Interfaces',
      autor: 'Equipe Exemplo',
      categoria: 'Design',
      descricao: 'Item ficticio para exercitar categorias e componentes visuais.',
    ),
  ];
}
