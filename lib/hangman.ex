
defmodule Hangman do
  use Application

  @moduledoc """


  main supervisor(strategy: other_for_one)
  ------dictionary server
  ------game supervisor(strategy: one_for_one)
        ------game server

  Main supervisor is the top level, it manage dictionary server and game supervisor. Strategy other_for_one is used.
  Game supervisor use the strategy one_for_one.
  """

  def start(_type, _args) do

    import Supervisor.Spec, warn: false
    
    children = [worker(Hangman.Dictionary, []),
                worker(Hangman.GameSupervisor, [])
    ]
     
    opts = [strategy: :other_for_one, name: Hangman.Supervisor]
    Supervisor.start_link(children, opts)
  end
end