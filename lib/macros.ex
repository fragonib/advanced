defmodule Macros do
  defmacro first_macro(code) do
    IO.inspect(quote do: unquote(code))
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

    # Trying to invoke a macro recursively (currently not working)

    # quote do
    #   case unquote(n) do
    #     0 -> nil
    #     _ ->
    #       unquote(do_clause)
    #       My.times (unquote(n)-1), do: unquote(clause)
    #   end
    # end

    # Do the same with for
    quote do
      for _ <- 1..unquote(n) do
        unquote(do_clause)
      end
    end
  end
end
