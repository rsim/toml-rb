require_relative 'helper'
require_relative 'toml_examples'

class TomlTest < Test::Unit::TestCase
  def test_file_v_0_4_0
    path = File.join(File.dirname(__FILE__), 'example-v0.4.0.toml')
    parsed = TOML.load_file(path)
    hash = TomlExamples.example_v_0_4_0

    assert_equal hash['Array'], parsed['Array']
    assert_equal hash['Booleans'], parsed['Booleans']
    assert_equal hash['Datetime'], parsed['Datetime']
    assert_equal hash['Float'], parsed['Float']
    assert_equal hash['Integer'], parsed['Integer']
    assert_equal hash['String'], parsed['String']
    assert_equal hash['Table'], parsed['Table']
    assert_equal hash['products'], parsed['products']
    assert_equal hash['fruit'], parsed['fruit']
  end

  def test_file
    path = File.join(File.dirname(__FILE__), 'example.toml')
    parsed = TOML.load_file(path)

    assert_equal TomlExamples.example, parsed
  end

  def test_hard_example
    path = File.join(File.dirname(__FILE__), 'hard_example.toml')
    parsed = TOML.load_file(path)

    assert_equal TomlExamples.hard_example, parsed
  end

  def test_symbolize_keys
    path = File.join(File.dirname(__FILE__), 'example.toml')
    parsed = TOML.load_file(path, symbolize_keys: true)

    hash = {
      title: 'TOML Example',

      owner: {
        name: 'Tom Preston-Werner',
        organization: 'GitHub',
        bio: "GitHub Cofounder & CEO\nLikes tater tots and beer.",
        dob: Time.utc(1979, 05, 27, 07, 32, 00)
      },

      database: {
        server: '192.168.1.1',
        ports: [8001, 8001, 8002],
        connection_max: 5000,
        enabled: true
      },

      servers: {
        alpha: {
          ip: '10.0.0.1',
          dc: 'eqdc10'
        },
        beta: {
          ip: '10.0.0.2',
          dc: 'eqdc10'
        }
      },

      clients: {
        data: [%w(gamma delta), [1, 2]],
        hosts: %w(alpha omega)
      },

      amqp: {
        exchange: {
          durable: true,
          auto_delete: false
        }
      }
    }

    assert_equal(hash, parsed)
  end

  def test_line_break
    parsed = TOML.parse("hello = 'world'\r\nline_break = true")
    assert_equal({ 'hello' => 'world', 'line_break' => true }, parsed)
  end
end
