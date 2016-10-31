defmodule Hangman.GameServer do

  use GenServer
  alias Hangman.Game, as: gm 

  def start_link(word) do
    GenServer.start_link(__MODULE__, word, name: :game)
  end

  def start_link() do
    GenServer.start_link(__MODULE__, GenServer.call(:dictionary, :random_word), name: :game)
  end

  def move(guess) do
    GenServer.call :game, {:move, guess}
  end

  def letters_already_used() do
    GenServer.call :game, :letters_already_used
  end

  def turns_left() do
    GenServer.call :game, :turns_left
  end

  def word_as_string() do
    GenServer.call :game, :word_as_string
  end

  def word_length() do
    GenServer.call :game, :word_length
  end
  
  def word_as_string(reverse) do
    GenServer.call :game, {:word_as_string, reverse}
  end

  def crash(:normal) do
    GenServer.stop(:game, :normal)
  end
  
  #________________________________

  def init(word) do
    {:ok, gm.new_game(word)}    
  end

  def handle_call({:make_move, guess},  _from, state) do
    {new_state, res, _} = gm.make_move(state, guess)
    { :reply, res, new_state}
  end

  def handle_call(:letters_used_so_far,  _from, state) do
    { :reply, gm.letters_used_so_far(state), state}
  end
  
  def handle_call(:turns_left,  _from, state) do
    { :reply, gm.turns_left(state), state}
  end

  def handle_call(:word_as_string,  _from, state) do
    { :reply, gm.word_as_string(state), state}
  end

  def handle_call(:word_length,  _from, state) do
    { :reply, gm.word_length(state), state}
  end

  def handle_call({:word_as_string, reverse},  _from, state) do
    { :reply, gm.word_as_string(state, reverse), state}
  end


end