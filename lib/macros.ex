defmodule My do
  def if_no_macro(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    case condition do
      val when val in [false, nil] ->
        else_clause

      _otherwise ->
        do_clause
    end
  end

  defmacro if(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(else_clause)
        _ -> unquote(do_clause)
      end
    end
  end

  defmacro unless(condition, clause) do
    do_clause = Keyword.get(clause, :do, nil)

    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(do_clause)
        _ -> nil
      end
    end

  end

  defmacro times(n, clause) do
    do_clause = Keyword.get(clause, :do, nil)

      quote do
        for _ <- 1..unquote(n) do
          unquote(do_clause)
        end
      end

  end

  @spec macro(any) :: any
  defmacro macro(code) do
    IO.inspect(quote do: unquote(code))
  end

end
