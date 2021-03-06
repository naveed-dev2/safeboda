defmodule Safeboda.Accounts do
  import Ecto.Query, warn: false

  alias Safeboda.Repo
  alias Safeboda.Accounts.{User, Driver, Passenger, Ride}

  def get_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, :not_found}

      user ->
        {:ok, user}
    end
  end

  @doc """
  Gets a single user.
  Raises `Ecto.NoResultsError` if the User does not exist.
  ## Examples
      iex> get_user!(123)
      %User{}
      iex> get_user!(456)
      ** (Ecto.NoResultsError)
  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets list of drivers.

  ## Examples

      iex> list_drivers()
      %Driver{}
      []
  """
  def list_drivers(), do: Repo.all(Driver)

  @doc """
  Gets a single driver.

  ## Examples

      iex> get_driver(123)
      %Driver{}
      nil
  """
  def get_driver(driver_id), do: Repo.get(Driver, driver_id)

  @doc """
  Creates a driver.

  ## Examples

      iex> create_driver(attrs)
      {:ok, %Driver{}}
      {:error, %Ecto.Changeset{}}
  """
  def create_driver(attrs \\ %{}) do
    %Driver{}
    |> Driver.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a driver.

  ## Examples

      iex> update_driver(attrs)
      {:ok, %Driver{}}
      {:error, %Ecto.Changeset{}}
  """
  def update_driver(%Driver{} = driver, attr \\ %{}) do
    driver
    |> Driver.update_changeset(attr)
    |> Repo.update()
  end

  @doc """
  Gets list of passengers.

  ## Examples

      iex> list_passengers()
      %Passenger{}
      []
  """
  def list_passengers(), do: Repo.all(Passenger)

  @doc """
  Creates a passenger.

  ## Examples

      iex> create_passenger(attrs)
      {:ok, %Passenger{}}
      {:error, %Ecto.Changeset{}}
  """
  def create_passenger(attrs \\ %{}) do
    %Passenger{}
    |> Passenger.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets list of ongoing ride.

  ## Examples

      iex> list_ongoing_rides()
      %Ride{}
      []
  """
  def list_ongoing_rides() do
    query =
      from r in Ride,
        where: r.status == "ongoing",
        preload: [:driver, :passenger]

    Repo.all(query)
  end

  @doc """
  check an ongoing ride for driver_id and passenger_id.

  ## Examples

      iex> ongoing_ride_exist?(1, 1)
      true
      false
  """
  def ongoing_ride_exists?(passenger_id, driver_id) do
    query =
      from r in Ride,
        where:
          (r.driver_id == ^driver_id or r.passenger_id == ^passenger_id) and r.status == "ongoing"

    Repo.exists?(query)
  end

  @doc """
  check a ride.

  ## Examples

      iex> create_ride(%{...})
      {:ok, %Ride{}}
      {:error, %Ecto.Changeset{}}
  """
  def create_ride(passenger_id, driver_id, attrs \\ %{}) do
    attrs =
      attrs
      |> Map.put("passenger_id", passenger_id)
      |> Map.put("driver_id", driver_id)
      |> Map.put("status", "ongoing")

    %Ride{}
    |> Ride.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets single ride.

  ## Examples

      iex> get_ride(123)
      {:ok, %Ride{}}
      nil
  """
  def get_ride(ride_id), do: Repo.get(Ride, ride_id) |> Repo.preload([:driver, :passenger])

  @doc """
  update a ride.

  ## Examples

      iex> update_ride(123, %{...})
      {:ok, %Ride{}}
      {:error, %Ecto.Changeset{}}
  """
  def update_ride(%Ride{} = ride, attr \\ %{}) do
    ride
    |> Ride.update_changeset(attr)
    |> Repo.update()
  end
end
