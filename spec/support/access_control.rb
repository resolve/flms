#####
# Complex access control tests.
#


# Verifies that the given action is accessible to the 'user' account and admins.
shared_examples 'an action accessible only to logged-in users' do
  it_should_behave_like 'an action accessible to the user'
  it_should_behave_like 'an action not accessible to the world'
end

# Verifies that the given action is accessible to everybody.
shared_examples 'an action accessible without login' do
  it_should_behave_like 'an action accessible to the user'
  it_should_behave_like 'an action accessible to the world'
end


#####
# Individual access control tests.
#


# Verifies that the 'user' user can perform the current action.
shared_examples 'an action accessible to the user' do
  before :each do
    sign_in user_1
    request
  end
  it_should_behave_like 'http access granted'
  it_should_behave_like 'database changed'
end

# Verifies that the given action can be performed without login.
shared_examples 'an action accessible to the world' do
  before :each do
    request
  end
  it_should_behave_like 'http access granted'
  it_should_behave_like 'database changed'
end

# Verifies that the given action cannot be performed without login.
shared_examples 'an action not accessible to the world' do
  before :each do
    request
  end
  it_should_behave_like 'http access denied'
  it_should_behave_like 'database not changed'
end



#####
# Private implementation details.
#

# Verifies that the http response confirms access granted.
shared_examples 'http access granted' do
  it do
    response = defined?(access_granted_check) ? access_granted_check : default_access_granted_check
    expect(response).to be_true
  end
end

# Verifies that the http response denied access.
shared_examples 'http access denied' do
  it do
    response = defined?(access_granted_check) ? access_granted_check : default_access_granted_check
    expect(response).to be_false
  end
end

# Verifies that the database changes were performed.
shared_examples 'database changed' do
  it do
    expect(database_performed_check).to be_true if defined? database_performed_check
  end
end

# Verifies that the database changes were not performed.
shared_examples 'database not changed' do
  it do
    expect(database_performed_check).to be_false if defined? database_performed_check
  end
end

