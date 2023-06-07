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
    explain_ast(do_clause)
  end

  def explain_ast({operator, _, [{_, _, _} = left, {_, _, _} = right]}) do
    "#{explain_ast(left)}, #{explain_ast(right)}, then #{explain_op(operator)} them"
  end

  def explain_ast({operator, _, [{_, _, _} = left, right]}) do
    case operator do
      :+ -> "#{explain_ast(left)}, then #{explain_op(operator)} #{explain_ast(right)}"
      :- -> "#{explain_ast(left)}, then #{explain_op(operator)} #{explain_ast(right)} from it"
      :* -> "#{explain_ast(left)}, then #{explain_op(operator)} #{explain_ast(right)}"
      :/ -> "#{explain_ast(left)}, then #{explain_op(operator)} it by #{explain_ast(right)}"
    end
  end

  def explain_ast({operator, _, [left, {_, _, _} = right]}) do
    case operator do
      :+ -> "#{explain_ast(right)}, then #{explain_op(operator)} #{explain_ast(left)}"
      :- -> "#{explain_ast(right)}, then #{explain_op(operator)} it from #{explain_ast(left)}"
      :* -> "#{explain_ast(right)}, then #{explain_op(operator)} #{explain_ast(left)}"
      :/ -> "#{explain_ast(right)}, then #{explain_op(operator)} #{explain_ast(left)} by it"
    end
  end

  def explain_ast({operator, _, [left, right]}) do
    case operator do
      :+ -> "#{explain_op(operator)} #{explain_ast(left)} and #{explain_ast(right)}"
      :- -> "#{explain_op(operator)} #{explain_ast(right)} from #{explain_ast(left)}"
      :* -> "#{explain_op(operator)} #{explain_ast(left)} and #{explain_ast(right)}"
      :/ -> "#{explain_op(operator)} #{explain_ast(left)} by #{explain_ast(right)}"
    end
  end

  def explain_ast(number) do
    inspect(number)
  end

  def explain_op(operator) do
    case operator do
      :+ -> "add"
      :- -> "subtract"
      :* -> "multiply"
      :/ -> "divide"
    end
  end
end
