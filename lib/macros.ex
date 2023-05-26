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

  # defmacro assert({:=, meta, [left, right]} = assertion) do
  #   code = escape_quoted(:assert, meta, assertion)

  #   check =
  #     quote generated: true do
  #       if right do
  #         :ok
  #       else
  #         raise ExUnit.AssertionError,
  #           expr: expr,
  #           message: "Expected truthy, got #{inspect(right)}"
  #       end
  #     end

  #   __match__(left, right, code, check, __CALLER__)
  # end

  defmacro explain(clause) do
    do_clause = Keyword.get(clause, :do, nil)
    explainf(do_clause)
  end


  def explainf({:/, _, [{_, _, _} = left, {_, _, _} = right]}) do
    "#{explainf(left)}, #{explainf(right)}, then #{explainop(:/)} them"
  end
  def explainf({:/, _, [{_, _, _} = left, right]}) do
    "#{explainf(left)}, then #{explainop(:/)} it by #{explainf(right)}"
  end
  def explainf({:/, _, [left, {_, _, _} = right]}) do
    "#{explainf(right)}, then #{explainop(:/)} #{explainf(left)} by it"
  end
  def explainf({:/, _, [left, right]}) do
    "#{explainop(:/)} #{explainf(left)} by #{explainf(right)}"
  end

  def explainf({:-, _, [{_, _, _} = left, {_, _, _} = right]}) do
    "#{explainf(left)}, #{explainf(right)}, then #{explainop(:-)} them"
  end
  def explainf({:-, _, [{_, _, _} = left, right]}) do
    "#{explainf(left)}, then #{explainop(:-)} #{explainf(right)} from it"
  end
  def explainf({:-, _, [left, {_, _, _} = right]}) do
    "#{explainf(right)}, then #{explainop(:-)} it from #{explainf(left)}"
  end
  def explainf({:-, _, [left, right]}) do
    "#{explainop(:-)} #{explainf(right)} from #{explainf(left)}"
  end


  def explainf({operator, _, [{_, _, _} = left, {_, _, _} = right]}) do
    "#{explainf(left)}, #{explainf(right)}, then #{explainop(operator)} them"
  end
  def explainf({operator, _, [{_, _, _} = left, right]}) do
    "#{explainf(left)}, then #{explainop(operator)} #{explainf(right)}"
  end
  def explainf({operator, _, [left, {_, _, _} = right]}) do
    "#{explainf(right)}, then #{explainop(operator)} #{explainf(left)}"
  end
  def explainf({operator, _, [left, right]}) do
    "#{explainop(operator)} #{explainf(left)} and #{explainf(right)}"
  end

  def explainop(operator) do
    case operator do
      :+ -> "add"
      :- -> "subtract"
      :* -> "multiply"
      :/ -> "divide"
    end
  end

  def explainf(number) do
    inspect(number)
  end

end
