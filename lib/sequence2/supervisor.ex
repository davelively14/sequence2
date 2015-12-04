defmodule Sequence.Supervisor do

  use Supervisor

  def start_link(initial_number) do
    # This will autmoatically invoke the init callback
    result = { :ok, sup } = Supervisor.start_link(__MODULE__, [initial_number])

    # Control returns here after init completes
    start_workers(sup, initial_number)
    result
  end

  def start_workers(sup, initial_number) do
    # Start the stash worker
    { :ok, stash } = Supervisor.start_child(sup, worker(Sequence.Stash, [initial_number]))
    # and then the subsupervisor for the actual sequence server
    Supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash]))
  end

  # Called on Supervisor.start_link is invoked above. Supervise is called, passes
  # an empty list. Supervisor is now running, but with no children. OTP returns control
  # back to the start_link function.
  def init(_) do
    supervise [], strategy: :one_for_one
  end
end