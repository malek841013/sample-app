require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	#test item
		#Visit the login path
		#Verify that the new sessions from renders properly
		#Post to the sessions path with an invalid params hash.
		#Verify that the new sessions form gets re-rendered and that a flash message apperars.
		#Visit another page(such as the Home page)
		#Verify that the flash message doesn't appear on the new page.
	def setup
		@user = users(:michael)
	end

	test "login with invalid information" do
		get login_path
		assert_template 'sessions/new'
		post login_path, session: { email: @user.email, password: 'password' }
		assert_redirected_to @user
		follow_redirect!
		assert_template 'users/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", user_path(@user)

#		assert_not flash.empty?
#		get root_path
#		assert flash.empty?
	end
end
