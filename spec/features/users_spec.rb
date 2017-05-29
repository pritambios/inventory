require 'rails_helper'

describe "User" do
  subject { page }

  let(:user) { create(:user) }

  describe "signup page" do
    before { visit new_user_path }

    it { should have_content('Sign up') }
  end

  describe ""
