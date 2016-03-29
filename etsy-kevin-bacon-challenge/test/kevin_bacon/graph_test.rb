require 'test_helper'

class KevinBacon::GraphTest < Minitest::Test
  def setup
    @films_path = File.expand_path(
      File.join(File.dirname(__FILE__), '..', '..', 'data/films')
    )
    @graph = KevinBacon::Graph.new

    @graph.add_edge('Denzel Washington', 'Kevin Bacon', 'Into the Wild')
    @graph.add_edge('Denzel Washington', 'Kevin Bacon', 'Brave')
    @graph.add_edge('Olivia Wilde', 'Denzel Washington', 'Fire')
    @graph.add_edge('Curtis Jackson', 'James Franco', 'Gone')
  end

  def test_that_it_has_a_version_number
    refute_nil ::KevinBacon::Graph::VERSION
  end

  def test_a_graph
    assert_instance_of KevinBacon::Graph, @graph
  end

  def test_it_is_created
    refute_nil @graph
  end

  def test_graph_structure
    nodes = {
      'Denzel Washington' => {
        'Kevin Bacon' => [
          'Into the Wild',
          'Brave'
        ],
        'Olivia Wilde' => [
          'Fire'
        ]
      },
      'Kevin Bacon' => {
        'Denzel Washington' => [
          'Into the Wild',
          'Brave'
        ]
      },
      'Olivia Wilde' => {
        'Denzel Washington' => [
          'Fire'
        ]
      },
      'Curtis Jackson' => {
        'James Franco' => [
          'Gone'
        ]
      },
      'James Franco' => {
        'Curtis Jackson' => [
          'Gone'
        ]
      }
    }
    assert_equal @graph.nodes, nodes
  end

  def test_initial_node_count
    assert_equal @graph.num_nodes, 5
  end

  def test_initial_edge_count
    assert_equal @graph.num_edges, 3
  end

  def test_initial_size
    assert_equal @graph.size, 8
  end

  def test_basic_removal_1
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Into the Wild')
    refute_includes @graph.nodes['Denzel Washington']['Kevin Bacon'], 'Into the Wild'
  end

  def test_basic_removal_2
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Into the Wild')
    refute_includes @graph.nodes['Kevin Bacon']['Denzel Washington'], 'Into the Wild'
  end

  def test_complete_removal_1
    @graph.remove_edge('Olivia Wilde', 'Denzel Washington', 'Fire')
    refute_includes @graph.nodes['Denzel Washington'], 'Olivia Wilde'
  end

  def test_complete_removal_2
    @graph.remove_edge('Olivia Wilde', 'Denzel Washington', 'Fire')
    assert_nil @graph.nodes['Olivia Wilde']
  end

  def test_basic_removal_node_count
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Into the Wild')
    assert_equal @graph.num_nodes, 5
  end

  def test_basic_removal_edge_count
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Into the Wild')
    assert_equal @graph.num_edges, 3
  end

  def test_basic_removal_size
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Into the Wild')
    assert_equal @graph.size, 8
  end

  def test_complete_removal_node_count
    @graph.remove_edge('Olivia Wilde', 'Denzel Washington', 'Fire')
    assert_equal @graph.num_nodes, 4
  end

  def test_complete_removal_edge_count
    @graph.remove_edge('Olivia Wilde', 'Denzel Washington', 'Fire')
    assert_equal @graph.num_edges, 2
  end

  def test_complete_removal_size
    @graph.remove_edge('Olivia Wilde', 'Denzel Washington', 'Fire')
    assert_equal @graph.size, 6
  end

  def test_purge_node_count
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Into the Wild')
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Brave')
    @graph.remove_edge('Olivia Wilde', 'Denzel Washington', 'Fire')
    @graph.remove_edge('Curtis Jackson', 'James Franco', 'Gone')
    assert_equal @graph.num_nodes, 0
  end

  def test_purge_edge_count
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Into the Wild')
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Brave')
    @graph.remove_edge('Olivia Wilde', 'Denzel Washington', 'Fire')
    @graph.remove_edge('Curtis Jackson', 'James Franco', 'Gone')
    assert_equal @graph.num_edges, 0
  end

  def test_purge_size
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Into the Wild')
    @graph.remove_edge('Denzel Washington', 'Kevin Bacon', 'Brave')
    @graph.remove_edge('Olivia Wilde', 'Denzel Washington', 'Fire')
    @graph.remove_edge('Curtis Jackson', 'James Franco', 'Gone')
    assert_equal @graph.size, 0
  end

  def test_find_existing_degrees_1
    path = @graph.find_degrees('Olivia Wilde')
    assert_equal path, ['Olivia Wilde', 'Denzel Washington', 'Kevin Bacon']
  end

  def test_find_existing_degrees_2
    path = @graph.find_degrees('Denzel Washington')
    assert_equal path, ['Denzel Washington', 'Kevin Bacon']
  end

  def test_find_non_existing_degrees_1
    assert_empty @graph.find_degrees('Curtis Jackson')
  end

  def test_find_non_existing_degrees_2
    assert_empty @graph.find_degrees('John Doe')
  end

  def test_pretty_path_empty
    assert_empty @graph.pretty_path('John Doe')
  end

  def test_pretty_path_1
    path_str = 'Denzel Washington <(Into the Wild)> Kevin Bacon'
    assert_equal @graph.pretty_path('Denzel Washington'), path_str
  end

  def test_pretty_path_2
    path_str = 'Olivia Wilde <(Fire)> Denzel Washington <(Into the Wild)> Kevin Bacon'
    assert_equal @graph.pretty_path('Olivia Wilde'), path_str
  end

  def test_build_no_path_size
    graph_build = KevinBacon::Graph.build
    assert_equal graph_build.size, 0
  end

  def test_build_no_path_nodes_empty
    graph_build = KevinBacon::Graph.build
    assert_empty graph_build.nodes
  end

  def test_build_no_path_num_edges
    graph_build = KevinBacon::Graph.build
    assert_equal graph_build.num_edges, 0
  end

  def test_build_no_path_num_nodes
    graph_build = KevinBacon::Graph.build
    assert_equal graph_build.num_nodes, 0
  end

  def test_build_path_size
    graph_build = KevinBacon::Graph.build(@films_path)
    assert_equal graph_build.size, 508908
  end

  def test_build_path_num_nodes
    graph_build = KevinBacon::Graph.build(@films_path)
    assert_equal graph_build.num_nodes, 26027
  end

  def test_build_path_num_edges
    graph_build = KevinBacon::Graph.build(@films_path)
    assert_equal graph_build.num_edges, 482881
  end

  def test_build_pretty_path_1
    graph_build = KevinBacon::Graph.build(@films_path)
    possible = ['Alec Guinness <(Kafka)> Theresa Russell <(Wild Things)> Kevin Bacon']
    assert_includes possible, graph_build.pretty_path('Alec Guinness')
  end

  def test_build_pretty_path_2
    graph_build = KevinBacon::Graph.build(@films_path)
    possible = ['Johnny Depp <(Public Enemies)> Billy Crudup <(Sleepers)> Kevin Bacon']
    assert_includes possible, graph_build.pretty_path('Johnny Depp')
  end

  def test_build_pretty_path_2
    graph_build = KevinBacon::Graph.build(@films_path)
    possible = ['Olivia Wilde <(The Incredible Burt Wonderstone)> Steve Carell <(Crazy, Stupid, Love.)> Kevin Bacon']
    assert_includes possible, graph_build.pretty_path('Olivia Wilde')
  end

end
