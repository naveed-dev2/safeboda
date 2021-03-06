# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Safeboda.Repo.insert!(%Safeboda.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Safeboda.Repo
alias Safeboda.Accounts.User

Repo.insert!(User.changeset(%User{}, %{email: "admin@safeboda.com", password: "password"}))
