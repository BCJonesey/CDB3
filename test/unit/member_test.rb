require 'test_helper'

class MemberTest < ActiveSupport::TestCase
   test "get member name" do
    assert "Darren Gagne" == members(:darren_mirror).user.name
   end
end
