defmodule Hangman.Dictionary do

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :dict)
  end

  def random_word do
    GenServer.call :dict, :random_word
  end

  def words_of_length(len) do
    GenServer.call :dict, {:words_of_length, len} 
  end

  
  def handle_call(:random_word, _from, _) do
    word = word_list
    |> Enum.random
    |> String.trim
    { :reply, word, []}
  end

  def handle_call({:words_of_length, len}, _from, _) do
    c = word_list
    |> Stream.map(&String.trim/1)
    |> Enum.filter(&(String.length(&1) == len))
    { :reply, c, []}
  end

  defp word_list do
    @word_list_file_name
    |> File.open!
    |> IO.stream(:line)
  end

end