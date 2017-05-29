module RequestHelper

  def current_user
    @current_user ||= User.find_by(session[:user_id])
  end

  def user_sign_in(user)
    session[:user_id] = user.id
  end
  def sign_in
    stub_omniauth
    visit root_path
    expect(page).to have_text("Inventory
anagement System")
    find("a.google-button").click
    expect(page).to have_content("paromita gorai")
    expect(page).to have_link("Logout")
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "105700521746401668293",
      info: {
        email: "paromitadgp@gmail.com",
        first_name: "paromita",
        last_name: "gorai"
      },
      credentials: {
        token: "ya29.GltZBJ4gmGmPNRpW-OSu149AvQVERVS6yRa2BtZ8A4WeEqB288icYWWregVDQS_M0tJsTzxbrA5S-5jIZmlF6dEnF27K9weB9tThwXKOGR-NyZ-P6mRcS8l8_WSM",
        expires_at: 1496046844,
        expires: true
      }
    })
  end

  def add_item(item = nil, category = nil, brand = nil, employee = nil)
    visit new_item_path
      fill_in "category_id", with: category
      fill_in "brand_id", with: brand
      fill_in "employee_id", with: employee
      click_button "Create"
  end
end
