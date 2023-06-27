defmodule Pento.Survey.Demographic.QueryTest do
  use Pento.DataCase
  import Pento.AccountsFixtures
  alias Pento.Survey.Demographics.Query

  setup do
    %{user: user_fixture()}
  end

  describe "for_user/2" do
    test "builds query for a demographic user", %{user: user} do
      q = Query.for_user(user)

      assert q
    end
  end
end
