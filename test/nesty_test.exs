defmodule NestyTest do
    use ExUnit.Case
    doctest Nesty

    describe "keyword" do
        test "empty" do
            assert nil == Nesty.get([], [:a])
            assert :foo == Nesty.get([], [a: :foo])
            assert :bar == Nesty.get([], [:a], :bar)
        end

        test "missing field" do
            assert nil == Nesty.get([a: [b: [c: 1]]], [:d, :b])
            assert :foo == Nesty.get([a: [b: [c: 1]]], [{ :d, :foo }, :b])
            assert :bar == Nesty.get([a: [b: [c: 1]]], [:d, :b], :bar)

            assert nil == Nesty.get([a: [b: [c: 1]]], [:a, :d])
            assert :foo == Nesty.get([a: [b: [c: 1]]], [:a, d: :foo])
            assert :bar == Nesty.get([a: [b: [c: 1]]], [:a, :d], :bar)

            assert nil == Nesty.get([a: [b: [c: 1]]], [:a, :b, :d])
            assert :foo == Nesty.get([a: [b: [c: 1]]], [:a, :b, d: :foo])
            assert :bar == Nesty.get([a: [b: [c: 1]]], [:a, :b, :d], :bar)

            assert nil == Nesty.get([a: [b: [c: 1]]], [:a, :b, :c, :d])
            assert :foo == Nesty.get([a: [b: [c: 1]]], [:a, :b, :c, d: :foo])
            assert :bar == Nesty.get([a: [b: [c: 1]]], [:a, :b, :c, :d], :bar)
        end

        test "found field" do
            assert [b: [c: 1]] == Nesty.get([a: [b: [c: 1]]], [:a])
            assert [c: 1] == Nesty.get([a: [b: [c: 1]]], [:a, :b])
            assert 1 == Nesty.get([a: [b: [c: 1]]], [:a, :b, :c])
        end

        test "non-atom field" do
            assert_raise ArgumentError, fn -> Nesty.get([{ "a", 1 }], ["a"]) end
            assert_raise ArgumentError, fn -> Nesty.get([{ 0, 1 }], [0]) end
            assert_raise ArgumentError, fn -> Nesty.get([{ {}, 1 }], [{}]) end
        end

        test "no keys" do
            assert_raise FunctionClauseError, fn -> Nesty.get([a: [b: [c: 1]]], []) end
        end
    end

    describe "map" do
        test "empty" do
            assert nil == Nesty.get(%{}, [:a])
            assert :foo == Nesty.get(%{}, [a: :foo])
            assert :bar == Nesty.get(%{}, [:a], :bar)
        end

        test "missing field" do
            assert nil == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:d, :b])
            assert :foo == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [{ :d, :foo }, :b])
            assert :bar == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:d, :b], :bar)

            assert nil == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :d])
            assert :foo == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, d: :foo])
            assert :bar == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :d], :bar)

            assert nil == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :b, :d])
            assert :foo == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :b, d: :foo])
            assert :bar == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :b, :d], :bar)

            assert nil == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :b, :c, :d])
            assert :foo == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :b, :c, d: :foo])
            assert :bar == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :b, :c, :d], :bar)
        end

        test "found field" do
            assert %{ b: %{ c: 1 } } == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a])
            assert %{ c: 1 } == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :b])
            assert 1 == Nesty.get(%{ a: %{ b: %{ c: 1 } } }, [:a, :b, :c])
        end

        test "non-atom field" do
            assert 1 == Nesty.get(%{ "a" => 1 }, ["a"])
            assert 1 == Nesty.get(%{ 0 => 1 }, [0])
            assert 1 == Nesty.get(%{ {} => 1 }, [{}])
        end

        test "no keys" do
            assert_raise FunctionClauseError, fn -> Nesty.get(%{ a: %{ b: %{ c: 1 } } }, []) end
        end
    end
end
