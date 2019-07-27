require 'rails_helper'


describe UserPolicy do 
  subject { described_class }

  permissions :index? do

    # it "denies access if user is not an admin or volunteer" do
    #   expect(subject).not_to permit(User.new(admin:false), User.new(volunteer: false))
    # end

    it "grants  access if the user is an admin or volunteer" do
      expect(subject).to permit(User.new().add_role :admin)
    end

  
  end
end
