defmodule Cloak.EncryptedField do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      alias Cloak.Encryptable

      @doc false
      def type, do: :binary

      @doc false
      def cast(value) do
        {:ok, value}
      end

      @doc false
      def dump(value) do
        value = value 
                |> before_encrypt 
                |> Cloak.encrypt

        {:ok, value}
      end

      @doc false
      def load(value) do
        value = value
                |> Cloak.decrypt
                |> after_decrypt

        {:ok, value}
      end

      @doc false
      def before_encrypt(value), do: to_string(value)

      @doc false
      def after_decrypt(value), do: value

      defoverridable [before_encrypt: 1, after_decrypt: 1]
    end
  end
end
