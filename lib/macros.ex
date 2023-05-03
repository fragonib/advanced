defmodule MyIf do
  def myif(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    case condition do
      val when val in [false, nil] ->
        else_clause

      _otherwise ->
        do_clause
    end
  end

  defmacro macro(code) do
    IO.inspect(quote do: IO.inspect(unquote(code)))
  end
end
